#!/usr/bin/env bash

set -o nounset
set -o pipefail

FORMULAE=("${@}")
SCRATCH="$(mktemp -d)"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

function err() {
	echo "${1}" >&2
}

function cleanup() {
	if [ -n "${SCRATCH}" ] && [ -d "${SCRATCH}" ]; then
		echo "Cleaning up ${SCRATCH}"
		rm -rf "${SCRATCH}"
	fi
}

trap cleanup EXIT

function get_current_version() {
	local formula_file="${1}"
	# Extract version from the URL line - handles both PyPI and GitHub
	grep -E '^\s*url ' "${formula_file}" |
		sed -E 's|.*/||' |
		sed -E 's/"$//' |
		sed -E 's|\.tar\.gz$||; s|\.zip$||' |
		sed -E 's|^v||; s|.*-||' |
		head -n1
}

function update_github_formula() {
	local formula="${1}"
	local formula_file="${2}"
	local github_repo="${3}"

	echo "Checking GitHub releases for ${github_repo}"

	# Fetch all releases and filter out pre-releases
	local latest_release
	latest_release="$(curl -s "https://api.github.com/repos/${github_repo}/releases" |
		jq -r '[.[] | select(.prerelease == false and .draft == false)] | first | .tag_name')"

	if [ -z "${latest_release}" ] || [ "${latest_release}" = "null" ]; then
		err "No stable releases found for ${github_repo}"
		return 1
	fi

	local current_version
	current_version="$(get_current_version "${formula_file}")"

	# Strip leading 'v' for comparison
	local latest_version="${latest_release#v}"
	local current_clean="${current_version#v}"

	echo "  Current: ${current_version}"
	echo "  Latest:  ${latest_release}"

	if [ "${current_clean}" = "${latest_version}" ]; then
		echo "  ✓ Already up to date"
		return 0
	fi

	echo "  → Updating formula"

	# Construct new URL
	local new_url="https://github.com/${github_repo}/archive/refs/tags/${latest_release}.tar.gz"

	# Download and calculate SHA256
	echo "  → Downloading ${new_url}"
	local tarball_path="${SCRATCH}/${formula}-${latest_release}.tar.gz"
	if ! curl -sL "${new_url}" -o "${tarball_path}"; then
		err "Failed to download ${new_url}"
		return 1
	fi

	local new_sha256
	new_sha256="$(shasum -a 256 "${tarball_path}" | awk '{print $1}')"
	echo "  → SHA256: ${new_sha256}"

	# Update the formula file
	# First, update the URL
	sed -i '' -E "s|url \"https://github\.com/${github_repo}/archive/refs/tags/v?[0-9]+\.[0-9]+\.[0-9]+[^\"]*\.tar\.gz\"|url \"${new_url}\"|" "${formula_file}"

	# Then, update the SHA256
	sed -i '' -E "s/sha256 \"[a-f0-9]{64}\"/sha256 \"${new_sha256}\"/" "${formula_file}"

	echo "  ✓ Updated ${formula_file}"
	rm -f "${tarball_path}"
}

function update_pypi_formula() {
	local formula="${1}"
	local formula_file="${2}"
	local package_name="${3}"

	echo "Checking PyPI releases for ${package_name}"

	local pypi_data
	pypi_data="$(curl -s "https://pypi.org/pypi/${package_name}/json")"

	local latest_version
	latest_version="$(echo "${pypi_data}" | jq -r '.info.version')"

	if [ -z "${latest_version}" ] || [ "${latest_version}" = "null" ]; then
		err "Failed to fetch latest version from PyPI for ${package_name}"
		return 1
	fi

	local current_version
	current_version="$(get_current_version "${formula_file}")"

	echo "  Current: ${current_version}"
	echo "  Latest:  ${latest_version}"

	if [ "${current_version}" = "${latest_version}" ]; then
		echo "  ✓ Already up to date"
		return 0
	fi

	echo "  → Updating formula"

	# Get the source distribution URL and SHA256 from PyPI
	local new_url
	local new_sha256
	new_url="$(echo "${pypi_data}" | jq -r --arg v "${latest_version}" \
		'.releases[$v][] | select(.packagetype == "sdist") | .url' | head -n1)"
	new_sha256="$(echo "${pypi_data}" | jq -r --arg v "${latest_version}" \
		'.releases[$v][] | select(.packagetype == "sdist") | .digests.sha256' | head -n1)"

	if [ -z "${new_url}" ] || [ -z "${new_sha256}" ]; then
		err "Failed to get source distribution for ${package_name} ${latest_version}"
		return 1
	fi

	echo "  → New URL: ${new_url}"
	echo "  → SHA256: ${new_sha256}"

	# Update the main package URL and SHA256
	local old_url_pattern
	old_url_pattern=$(grep -E '^\s*url "https://files\.pythonhosted\.org' "${formula_file}" | head -n1 | sed -E 's/^ +url "([^"]+)"/\1/')

	sed -i '' -E "s|url \"${old_url_pattern}\"|url \"${new_url}\"|" "${formula_file}"

	# Update the first SHA256 (the main package)
	# BSD sed (macOS) doesn't support GNU's 0,/pattern/ for first-occurrence replacement
	awk -v new_sha="${new_sha256}" \
		'!done && /sha256 "[a-f0-9]{64}"/ { sub(/sha256 "[a-f0-9]{64}"/, "sha256 \"" new_sha "\""); done=1 } { print }' \
		"${formula_file}" >"${formula_file}.tmp" && mv "${formula_file}.tmp" "${formula_file}"

	echo "  ✓ Updated ${formula_file}"
	echo ""
	echo "  ⚠  Dependencies may need updating. To update resources:"
	echo "     1. Ensure the tap is installed locally:"
	echo "        brew tap openshift-online/sre-tools ${REPO_ROOT}"
	echo "     2. Update the resources:"
	echo "        brew update-python-resources openshift-online/sre-tools/${formula}"
	echo "     3. (Optional) Untap when done:"
	echo "        brew untap openshift-online/sre-tools"
}

function update_formula() {
	local formula="${1}"
	local formula_file="${REPO_ROOT}/Formula/${formula}.rb"

	if [ ! -s "${formula_file}" ]; then
		err "Invalid formula: ${formula}. Skipping."
		return 1
	fi

	echo ""
	echo "=== Updating formula: ${formula} ==="

	# Check if it's a GitHub-based formula
	local github_repo
	github_repo=$(grep -oE 'url "https://github\.com/[^/]+/[^/"]+' "${formula_file}" |
		sed -E 's|url "https://github\.com/||; s|/archive.*||; s|\.git$||')

	if [ -n "${github_repo}" ]; then
		update_github_formula "${formula}" "${formula_file}" "${github_repo}"
		return $?
	fi

	# Check if it's a PyPI-based formula (pythonhosted.org)
	if grep -q 'files.pythonhosted.org' "${formula_file}"; then
		# Extract package name from the URL or formula name
		local package_name
		package_name=$(grep -oE 'files.pythonhosted.org/packages/[^/]+/[^/]+/[^/]+/([^/]+)-[0-9]' "${formula_file}" |
			sed -E 's|.*/([^/]+)-[0-9].*|\1|' | tr '_' '-' | head -n1)

		if [ -z "${package_name}" ]; then
			# Fallback: derive from formula name
			package_name=$(echo "${formula}" | tr '-' '_')
		fi

		update_pypi_formula "${formula}" "${formula_file}" "${package_name}"
		return $?
	fi

	err "Unknown formula type for ${formula}"
	return 1
}

# If no formula is passed, update all formulae
if [ "${#FORMULAE[@]}" -eq 0 ]; then
	while IFS= read -r file; do
		FORMULAE+=("$(basename "${file}" .rb)")
	done < <(find "${REPO_ROOT}/Formula" -type f -name '*.rb')
fi

for f in "${FORMULAE[@]}"; do
	update_formula "${f}"
done

echo ""
echo "=== Update complete ==="

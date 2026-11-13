class Omc < Formula
  desc "OpenShift Must-Gather Client"
  homepage "https://github.com/gmeghnag/omc"
  url "https://github.com/gmeghnag/omc/archive/refs/tags/v3.20.0.tar.gz"
  sha256 "37bf5e04706e801706b010e706d76cadb3f57ad568c7f1efaa66b3d1b8d15417"
  license "Apache-2.0"
  head "https://github.com/gmeghnag/omc.git", branch: "main"

  depends_on "go" => :build

  # The tarball vendors its dependencies, so the build needs no network.
  deny_network_access!

  def install
    ENV["CGO_ENABLED"] = "0"

    ldflags = %W[
      -s -w
      -X github.com/gmeghnag/omc/vars.OMCVersionTag=v#{version}
      -X github.com/gmeghnag/omc/vars.InstallMethod=homebrew
    ]

    system "go", "build", "-mod=vendor", *std_go_args(ldflags:)
    generate_completions_from_executable(bin/"omc", shell_parameter_format: :cobra)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/omc version")

    assert_match "is not a directory not a compressed file",
      shell_output("#{bin}/omc use #{testpath}/missing-must-gather 2>&1", 1)
  end
end

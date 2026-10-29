class RhAwsSamlLogin < Formula
  include Language::Python::Virtualenv

  desc "CLI tool to retrieve AWS temporary credentials using Red Hat SAML IDP"
  homepage "https://github.com/app-sre/rh-aws-saml-login"
  url "https://files.pythonhosted.org/packages/33/62/f829eeaa0703d069872a0329f8dfdfa0f5be8b2f28bbf6ad35911441924c/rh_aws_saml_login-0.15.2.tar.gz"
  sha256 "e9290434e8b3ab8da00879b44c5c9769cc598a6a535daa35b9e80703787ccca0"
  license "MIT"

  depends_on "python@3.14"
  uses_from_macos "libxml2"
  uses_from_macos "libxslt"

  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/5a/8e/38aa427ed5402449e226975b649c5dc73ccadfefeb95e6aecb8f8ea4b6b6/annotated_doc-0.0.5.tar.gz"
    sha256 "c7e58ce09192557605d8bbd92836d7e1d520ac9580096042c0bfd197efacf1bb"
  end

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/0f/d3/9426f7c627719bd0f8ab3827a91362805b72fc721dcddd61a3daef555d4a/boto3-1.43.120.tar.gz"
    sha256 "9d85840e721869f8202ab5f6b4ec3e697ac46343116cc8d1d0804ec58f90c503"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/dd/81/f45d4be966d44d01d9e342fecaacdd95909034c096b56cc8c209ede1f9d7/botocore-1.43.120.tar.gz"
    sha256 "f479cbb7273b9c0ea589a91a7abe38badda6353fb7c237a22c7461a06d279ee2"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/fd/11/b524cbd9bbdaca58608e4cf4053fd463417549e1959fa8d3aa18319f9555/certifi-2026.10.23.tar.gz"
    sha256 "a9895e6e2758b371e0545e321a3a8fd1fcfd9829ada8824a936dfb16aaaf36cd"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/33/1c/f41d4e74c28ab327ff3acd36053f7ea506c55872d7a90b0fa71aa3ab0c89/charset_normalizer-3.5.2.tar.gz"
    sha256 "39de2a259fc954455c57274dc94c79d5842774e1247a016aff30bc0efed0f4ef"
  end

  resource "cssselect" do
    url "https://files.pythonhosted.org/packages/c8/8b/dc32df939ab541fca6ee8964d26aa231dbe231cdc2b2713228161441ba9c/cssselect-1.6.0.tar.gz"
    sha256 "8c83a7139e97b93aa5ebdc0f46e785f7056a08a8bf201e597a6a2629d7eb11db"
  end

  resource "decorator" do
    url "https://files.pythonhosted.org/packages/60/8b/32f9823da46cde7df2087faa08cd98d01b908f8dcab982cdba9c84e85355/decorator-5.3.1.tar.gz"
    sha256 "4cbcdd55a6efadb9dbea26b858f4fb3264567b52d69ca0d25b721b553f60ea82"
  end

  resource "gssapi" do
    url "https://files.pythonhosted.org/packages/6b/fb/9492eb37b5786369b7e96fff2cf4040713acb33b96124813e058cbbd4356/gssapi-1.12.0.tar.gz"
    sha256 "0b48f17296f869db89221c3bde463fdff35152a4cb99ae4aaa42b0b64333fc6c"
  end

  resource "humanize" do
    url "https://files.pythonhosted.org/packages/0a/ea/13a1ef3c12d12662905801495283530251918b70d62d368f1d2e0272c70d/humanize-4.16.0.tar.gz"
    sha256 "7dc2244a2f84a4bfb1d36c37bac80cd78e35cdc5c119206d87b018e1445f3a3f"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f5/08/8eea9d4b8302028f3abb2c0813953f7aec26d33b7a8960ed760e65ff29fa/idna-3.20.tar.gz"
    sha256 "a7db850025b95ded1eae8a46181a1a6c56c92c96f0e2b005d9ff8dc0210cab44"
  end

  resource "iterfzf" do
    url "https://files.pythonhosted.org/packages/4c/5a/d955b2ee27ffc7bf48fcb99201e071a39bc68aaa3c3daf4fd4e487b7d21d/iterfzf-1.9.0.67.0.tar.gz"
    sha256 "9e9ddeba324a6bf7786f6033d1ed5030c2b36bce86ef63f9e76ecb84529e45ac"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/d3/59/322338183ecda247fb5d1763a6cbe46eff7222eaeebafd9fa65d4bf5cb11/jmespath-1.1.0.tar.gz"
    sha256 "472c87d80f36026ae83c6ddd0f1d05d4e510134ed462851fd5f754c8c3cbb88d"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/23/ad/28ecd7cb894d172f3c9c80a075eeeb2017ac62e3632cee05a5f9493547eb/lxml-6.1.3.tar.gz"
    sha256 "45222d94ddd511536f3b2f7d9deae3b2339b4ce0f075f1ca25703b07cad9dd21"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end

  resource "pyquery" do
    url "https://files.pythonhosted.org/packages/c5/d8/955aef5c4ba7e01c67779a9856c4030aa89b6600b78544eae8a22a91185b/pyquery-2.1.0.tar.gz"
    sha256 "75238388750fc6e254b7a52f771027b9beb3a6202b88048bef52a00b0abeadbb"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz"
    sha256 "37dd54208da7e1cd875388217d5e00ebd4179249f90fb72437e91a35459a0ad3"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/ac/c3/e2a2b89f2d3e2179abd6d00ebd70bff6273f37fb3e0cc209f48b39d00cbf/requests-2.34.2.tar.gz"
    sha256 "f288924cae4e29463698d6d60bc6a4da69c89185ad1e0bcc4104f584e960b9ed"
  end

  resource "requests-gssapi" do
    url "https://files.pythonhosted.org/packages/48/7b/f83ca4b28fbfe122461d8faf27f71ee9141e47473d5520a4f26fa0af04a6/requests_gssapi-1.4.0.tar.gz"
    sha256 "ba27eb329f4840d965bc8fa5d360c627c74349efa6156ca501ad89afc6a134f4"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/49/c5/0a5ce655109cb96b8dfad36908a4e108d15f5dc2eff8fbc3146c4312e704/s3transfer-0.19.3.tar.gz"
    sha256 "8326acc3d056d7f7b8a37110c7d2aea41f67e83f6ae79cd3b5fbcca34c726406"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/58/15/8b3609fd3830ef7b27b655beb4b4e9c62313a4e8da8c676e142cc210d58e/shellingham-1.5.4.tar.gz"
    sha256 "8dbca0739d487e5bd35ab3ca4b36e11c4078f3a234bfce294b0a0291363404de"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/94/e7/b2c673351809dca68a0e064b6af791aa332cf192da575fd474ed7d6f16a2/six-1.17.0.tar.gz"
    sha256 "ff70335d468e7eb6ec65b95b99d3a2836546063f63acc5171de367e834932a81"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/03/51/d33db42cc72ffd8c30777547b42d01f0cbf9d95a770457698d0174b3ed71/typer-0.27.3.tar.gz"
    sha256 "d0396f770a560ab1b0a8504e13b5f254b728cedb05c61cf0359e944e50ce8901"
  end

  resource "tzlocal" do
    url "https://files.pythonhosted.org/packages/d8/89/2bd035df331499589fc92e59375c17c6cea6a500453b2c5f6a6ec9572825/tzlocal-5.4.5.tar.gz"
    sha256 "ba976898bad27945178c9ca25c222c19e322b30c10342b9f40b46714f70d2d5f"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/e3/05/b17359e1cefb4f909b5e40b1b90a496d987258916dbbf88e842c729f510e/urllib3-2.8.0.tar.gz"
    sha256 "63bf2ead4c879426ebf22ef2a781eeb4aa3b4ae798a0435506f8687fd5bb9b63"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rh-aws-saml-login --version")
  end
end

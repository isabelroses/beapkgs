{
  lib,
  fetchFromGitHub,
  nix-update-script,
  buildGoModule,
}:
let
  version = "0.6.0";
in
buildGoModule {
  pname = "go-enum";
  inherit version;

  src = fetchFromGitHub {
    owner = "abice";
    repo = "go-enum";
    rev = "refs/tags/v${version}";
    hash = "sha256-Mt45Qz8l++bvBLKEpbX0m8iTkHDpsZtdYhhHUprQKY8=";
  };

  vendorHash = "sha256-YzIVI+PLZt24s/KjTxifWrvjrIU8jLvkC1lgw4yG6cg=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "an enum generator for go";
    homepage = "https://github.com/abice/go-enum";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}

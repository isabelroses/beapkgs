{
  rustPlatform,
  nix-update-script,
  fetchFromGitHub,
}:
let
  version = "0.3.0";
in
rustPlatform.buildRustPackage {
  pname = "bellado";
  inherit version;

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "bellado";
    rev = "refs/tags/v${version}";
    hash = "sha256-evko1/qE4oRXTMdCOGuwJRUkRm7Sxb5MhQCTLgx5Z+4=";
  };

  cargoHash = "sha256-N3jH/bjionN6ulxKrzFip2Oyc+cgQEJovxE7UxsDTEA=";

  doCheck = false;

  passthru.updateScript = nix-update-script { };
}

{
  lib,
  rustPlatform,
  openssl,
  pkg-config,
  nix-update-script,
  fetchFromGitHub,
}:
let
  version = "0-unstable-2024-10-13";
in
rustPlatform.buildRustPackage {
  pname = "blahaj";
  inherit version;

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "blahaj";
    rev = "1fb64b805dd15744919649b5ca9dc5e678492e5f";
    hash = "sha256-RdNeRmONn3LbYQ0mwCwAWOJx+F43+/agjRjIpLmdfiA=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-RdNeRmONn3LbYQ0mwCwAWOJx+F43+/agjRjIpLmdfiA=";

  buildInputs = [ openssl ];
  nativeBuildInputs = [ pkg-config ];

  env.BUILD_REV = version;

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "the resident discord bot of hell :3";
    homepage = "https://github.com/isabelroses/blahaj";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ isabelroses ];
    mainProgram = "blahaj";
  };
}

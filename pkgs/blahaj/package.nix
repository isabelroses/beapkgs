{
  lib,
  rustPlatform,
  openssl,
  pkg-config,
  nix-update-script,
  fetchFromGitHub,
}:
let
  version = "0-unstable-2024-11-21";
in
rustPlatform.buildRustPackage {
  pname = "blahaj";
  inherit version;

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "blahaj";
    rev = "fe01ebd5e1c525108cf3e4b18a89bd2b1e3b18d2";
    hash = "sha256-XBjOILHVhD89FaP8dNbIN8IWq8GGQosiSOfEOhsLS4I=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-i+KpdvbRRFOQRpWFMJMnjd3I+cSDIirwK8tDES4GegA=";

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

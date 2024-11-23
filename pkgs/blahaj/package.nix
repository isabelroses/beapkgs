{
  lib,
  rustPlatform,
  openssl,
  pkg-config,
  nix-update-script,
  fetchFromGitHub,
}:
let
  version = "0-unstable-2024-11-22";
in
rustPlatform.buildRustPackage {
  pname = "blahaj";
  inherit version;

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "blahaj";
    rev = "a7f97bdfc5a9707a5d16281dcf1eaf4a54a631e9";
    hash = "sha256-X+BOoTrAZWYD3zNRHEMuybX8Og0WPD5km34zMo4wSiw=";
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

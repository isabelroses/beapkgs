{
  lib,
  rustPlatform,
  pkg-config,
  openssl,
  fetchFromGitHub,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "purr";
  version = "1.1.0-unstable-2025-01-16";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "purr";
    rev = "913a3391eb3f8930aa058d4c3db9ee2ee738e4ee";
    hash = "sha256-8aG2XyfB+lEcYw9OQorqwn0DwoFi/PVoR9ng72MZARs=";
  };

  cargoHash = "sha256-5AjKMLG4cxWtr8rTJvGlpsNplyV3amNNWpslMsyPh4o=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "Utility commands for managing userstyles";
    homepage = "https://github.com/uncenter/purr";
    license = lib.licenses.mit;
    mainProgram = "purr";
  };
}

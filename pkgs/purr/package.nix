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
  version = "1.1.0-unstable-2025-01-15";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "purr";
    rev = "48b4c80aed4b571b62f949ea584b6699925f7653";
    hash = "sha256-/oF/SbtheOK15a+HgZeJTrUT/H5XEAtyJq9Hy+TjVpc=";
  };

  cargoHash = "sha256-1wR1zbp+3e0Cc4EAoEwJi4PpUAnceUTyZJ1qG8MXqps=";

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

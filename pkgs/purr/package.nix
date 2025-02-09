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
  version = "1.2.0-unstable-2025-01-18";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "purr";
    rev = "549536118988c5b5a448fb1b389e711dda74f786";
    hash = "sha256-rtwFhptQ7bSo0cCvbv/czwA7T3oD1tr1+dOc8i8GeXs=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-he9IBE83RJnePs/0lcsr0OtRNEbBnP/UIiGFevIDaWs=";

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
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}

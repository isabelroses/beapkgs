{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "ito";
  version = "0-unstable-2024-07-09";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "ito";
    rev = "30596468c71e1da2176eea78206486c60559bab6";
    hash = "sha256-g8hPXX91+TKijEMqDhhSeHSAYBYIkwnRnLff/yGhOWs=";
  };

  cargoHash = "sha256-4czKsg/gANG/bVMW+uYHbB53Gpf/USK9QE9fy/haxIs=";

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "A powerful string manipulation tool";
    homepage = "https://github.com/uncenter/ito";
    license = lib.licenses.mit;
    mainProgram = "ito";
  };
}

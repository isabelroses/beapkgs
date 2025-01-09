{
  lib,
  rustPlatform,
  nix-update-script,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nixpkgs-track";
  version = "0.2.0-unstable-2025-01-08";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "nixpkgs-track";
    rev = "ddc026982866719c1df7e517f969f6e3b615c93a";
    hash = "sha256-atzqGsPwY4m0/a6oDTH2wuhHbDmkwrW8fKX39X3V02U=";
  };

  cargoHash = "sha256-2ykBg8Ki3deut2/drSrDJdfw3m+tfo21ji1CsKYNo60=";

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "Track where Nixpkgs pull requests have reached";
    homepage = "https://github.com/uncenter/nixpkgs-track";
    license = lib.licenses.mit;
    mainProgram = "nixpkgs-track";
  };
}

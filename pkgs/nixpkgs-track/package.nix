{
  lib,
  openssl,
  pkg-config,
  rustPlatform,
  nix-update-script,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nixpkgs-track";
  version = "0-unstable-2024-10-10";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "nixpkgs-track";
    rev = "4792e406455f7dda87ee5915fdaaeaa9b44569fd";
    hash = "sha256-KnCrng2k2yGxxakA9OsFBeKozE4CXo3TaqG4/wqqaj8=";
  };

  cargoHash = "sha256-2MSOb88SPsry+Q3XAOW2S8cSiTcaQ2LzIFmgPXRlD10=";

  buildInputs = [
    openssl
  ];

  nativeBuildInputs = [ pkg-config ];

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

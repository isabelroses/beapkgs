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
  version = "0.2.0-unstable-2025-01-07";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "nixpkgs-track";
    rev = "7b10fc639400f822c97a731469cdfec31e6b68e5";
    hash = "sha256-nKQYINm0eZw5PMSaj7nfclcdZNrZT3aJDJ7cBzq8ZYE=";
  };

  cargoHash = "sha256-GhRhdWjuDG8dBXNTPyzZLew6MWuXsUrERBllLBB4AOM=";

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

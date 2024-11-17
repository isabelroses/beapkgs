{
  lib,
  openssl,
  pkg-config,
  rustPlatform,
  nix-update-script,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nixpkgs-using";
  version = "0-unstable-2024-10-31";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "nixpkgs-using";
    rev = "9824a8023dec1f183df66a3dff2c7fe9d41cb498";
    hash = "sha256-5bblEPHbLenricLHZYZw1OyXxoEZNlYgt/JCgnE6tas=";
  };

  cargoHash = "sha256-bZILuzLt25zbpGZ28dAv5nNgFrzu3gnTJflUrwCPAis=";

  buildInputs = [ openssl ];
  nativeBuildInputs = [ pkg-config ];

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "Find packages that you use that are currently being updated in Nixpkgs";
    homepage = "https://github.com/uncenter/nixpkgs-using";
    license = lib.licenses.mit;
    mainProgram = "nixpkgs-using";
  };
}

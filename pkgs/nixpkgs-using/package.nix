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
  version = "0-unstable-2025-01-07";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "nixpkgs-using";
    rev = "343d7aed2354704c01bebf6cc77e0cebe82c3de2";
    hash = "sha256-fTNzRc+S6qmiks0nZ+SUN8QfihNfyAhrAgo9+liSU2c=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-VjVmq4KmBikEZPP68TStHP3LzOulF10rxkRAL/VcUOk=";

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
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}

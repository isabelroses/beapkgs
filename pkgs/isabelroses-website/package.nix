{
  lib,
  just,
  dart-sass,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "isabelroses-website";
  version = "0-unstable-2024-12-22";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "e932cc325edf634aec8e2ddecb90c08b2dd29fca";
    hash = "sha256-WQg/Wsg0UzUqjFfNRUAg3t3HXxZOSKrGwzBEh3sXlvk=";
  };

  cargoHash = "sha256-ChuDlJhjW5jIpuys2u8gB+M+dae2lBpIBwbro364JvA=";

  nativeBuildInputs = [
    just
    dart-sass
  ];

  dontUseJustInstall = true;
  dontUseJustBuild = true;
  dontUseJustCheck = true;

  preBuild = ''
    just build-styles
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "isabelroses.com";
    homepage = "https://isabelroses.com/";
    license = with lib.licenses; [
      mit
      cc-by-nc-sa-40
    ];
    mainProgram = "isabelroses-website";
  };
}

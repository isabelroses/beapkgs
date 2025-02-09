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
  version = "0-unstable-2025-02-07";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "7db23d7c0ae6257da7512c15e13cbe12aecc5d74";
    hash = "sha256-vVpnUrSu13XkDUjI++7AyvDX/3HkZPq/jFKii2p+ORw=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-SbV7kh/V44HFdaigAyl0P1bmdISp3CzXC3TbISJ7s70=";

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
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}

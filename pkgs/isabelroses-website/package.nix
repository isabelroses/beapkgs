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
  version = "0-unstable-2025-02-01";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "c737d9674b8fea9240efc50dc22cda8c3a4bb770";
    hash = "sha256-X6zas7UdnBcufZfIE52DllXqnsUIU4XsKmptgVtls+g=";
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
  };
}

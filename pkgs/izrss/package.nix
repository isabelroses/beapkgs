{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:
let
  version = "0.1.0-unstable-2024-08-22";
in
buildGoModule {
  pname = "izrss";
  inherit version;

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "izrss";
    rev = "47460bfdfde0ec797daa52150fff6106819b7d0a";
    hash = "sha256-UcE/zzGjBVst6+tE/Znary7pvQIAELj6eB7T2m803BM=";
  };

  vendorHash = "sha256-VZzj+jQ00IvCSoTOoD4i/kNILxS3B3y8b11zfnDsfYs=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "A RSS feed reader for the terminal";
    homepage = "https://github.com/isabelroses/izrss";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ isabelroses ];
    mainPackage = "izrss";
  };
}

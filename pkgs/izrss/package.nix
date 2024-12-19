{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:
let
  version = "0.1.0-unstable-2024-12-18";
in
buildGoModule {
  pname = "izrss";
  inherit version;

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "izrss";
    rev = "ede8883b1545f40d43b2d2f2c10be9b238cb379e";
    hash = "sha256-Kt/gAXlXNw40F7U6sg9IISlajXTQ+Cep10u4bkGZt7Q=";
  };

  vendorHash = "sha256-/VTxJp96Z/ngwe/SD/zMrBe8kUlb09zABxndc2YXkoU=";

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

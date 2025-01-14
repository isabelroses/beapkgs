{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:
let
  version = "0.1.0-unstable-2025-01-13";
in
buildGoModule {
  pname = "izrss";
  inherit version;

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "izrss";
    rev = "d6f5dbe5ff1765e67df5a4630e586e1ad09ad551";
    hash = "sha256-FYnHpQjSYq5ZRgBWj84+Y5cq3oJcg4R62KmnK6MCToE=";
  };

  vendorHash = "sha256-yW26HcZc98m2RRS59MZsxzWCDsjTWCU3XqD9EhxVq+0=";

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

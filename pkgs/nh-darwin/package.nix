{
  lib,
  nvd,
  rustPlatform,
  installShellFiles,
  makeBinaryWrapper,
  nix-output-monitor,
  fetchFromGitHub,
  nix-update-script,
}:
let
  version = "0-unstable-2024-10-30";
in
rustPlatform.buildRustPackage {
  pname = "nh-darwin";
  inherit version;

  src = fetchFromGitHub {
    owner = "ToyVo";
    repo = "nh_darwin";
    rev = "028777665a62825b88703edaf5d8e79c61ba2e6d";
    hash = "sha256-YstBWQKfFRWHvs/xZlN8sXZXCemu6tuvvStxEGhMmTQ=";
  };

  cargoHash = "sha256-KZMZMNK5HQvOie0erQnaEzqfEvO2pq0wA95LDo263WU=";

  strictDeps = true;

  nativeBuildInputs = [
    installShellFiles
    makeBinaryWrapper
  ];

  preFixup = ''
    mkdir completions
    $out/bin/nh completions --shell bash > completions/nh.bash
    $out/bin/nh completions --shell zsh > completions/nh.zsh
    $out/bin/nh completions --shell fish > completions/nh.fish

    installShellCompletion completions/*
  '';

  postFixup = ''
    wrapProgram $out/bin/nh \
      --prefix PATH : ${
        lib.makeBinPath [
          nix-output-monitor
          nvd
        ]
      }
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    license = lib.licenses.eupl12;
    mainProgram = "nh";
  };
}

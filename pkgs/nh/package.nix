{
  lib,
  nvd,
  rustPlatform,
  installShellFiles,
  makeBinaryWrapper,
  nix-output-monitor,
  fetchFromGitHub,
  nix-update-script,
  use-nom ? true,
}:
let
  version = "4.0.0-beta.7-unstable-2025-01-13";
  rev = "f4da5cf5af09e01a0177e889aa6fc682c6176a67";

  rtp = lib.makeBinPath (
    [
      nvd
    ]
    ++ lib.optionals use-nom [
      nix-output-monitor
    ]
  );
in
rustPlatform.buildRustPackage {
  pname = "nh";
  inherit version;

  src = fetchFromGitHub {
    owner = "viperml";
    repo = "nh";
    inherit rev;
    hash = "sha256-MCUsaDZVi2FCVvLPXkekq5i1BxTX/5zyLLEJDFX1u5Y=";
  };

  cargoHash = "sha256-GPt3TPuDk0azDXl3UIGEanuLB9orR2R0D9h4Cs5xVaI=";

  strictDeps = true;

  nativeBuildInputs = [
    installShellFiles
    makeBinaryWrapper
  ];

  preFixup = ''
    mkdir completions
    $out/bin/nh completions bash > completions/nh.bash
    $out/bin/nh completions zsh > completions/nh.zsh
    $out/bin/nh completions fish > completions/nh.fish

    installShellCompletion completions/*
  '';

  postFixup = ''
    wrapProgram $out/bin/nh \
      --prefix PATH : ${rtp}
  '';

  env = {
    NH_REV = rev;
  };

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

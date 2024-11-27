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
  version = "4.0.0-beta.3-unstable-2024-11-27";
  rev = "88f31e46a70dca2dc248c640da28f65b5480f074";

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
    hash = "sha256-ssUxXpjuwzysAc3HhKbtdiiIBbRxn7Ro4GZvLaNsTfI=";
  };

  cargoHash = "sha256-6Idh7bz4uBBdoCuQHjacrAhn2qdPZBX0gMNF3FRRxfI=";

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

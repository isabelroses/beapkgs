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
  version = "3.6.0-0-unstable-2024-11-17";
in
rustPlatform.buildRustPackage {
  pname = "nh-darwin";
  inherit version;

  src = fetchFromGitHub {
    owner = "ToyVo";
    repo = "nh_darwin";
    rev = "f19fcb3ad4c2f0686c36243fd8a9f7793942dea2";
    hash = "sha256-u6rTrvXRii4wm1qs1F0/IcRDLwfEcEDxC5YO5NkL8Gg=";
  };

  cargoHash = "sha256-I3ArDu0VsvEesiqr9t42r7+sgabn9SgYilWWYr7X0pU=";

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

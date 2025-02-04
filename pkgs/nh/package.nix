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
  version = "4.0.0-beta.9-unstable-2025-02-03";
  rev = "8ef70b642b8351c010a48f43dda6a1ebf038f5d9";

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
    hash = "sha256-HcNEFumdZ4Y59CBB1h1IzOyPxwn0u/Wson6hhzItXCA=";
  };

  cargoHash = "sha256-rGc4+wRiztpSLw/UebktWWip0oFBHmQRBZpYg5Xuxns=";

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

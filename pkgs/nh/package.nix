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
  version = "4.0.0-beta.5-unstable-2024-12-11";
  rev = "6a69a145b0c7dbd5616bbded512b8bf8b5d2f8a4";

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
    hash = "sha256-I3ubew5jt8YZ27AOtIodRAYo0aew6wxY8UkWCSqz6B4=";
  };

  cargoHash = "sha256-/K03cPXiBCpv3PMl2W610utPAuEY8e0mkIGcapbu4ZU=";

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

{
  lib,
  nvd,
  pins,
  darwin,
  stdenv,
  rustPlatform,
  installShellFiles,
  makeBinaryWrapper,
  nix-output-monitor,
}:
let
  version = builtins.substring 0 7 pins.nh-darwin.version;
in
rustPlatform.buildRustPackage {
  pname = "nh-darwin";
  inherit version;

  inherit (pins.nh-darwin) src;
  strictDeps = true;

  nativeBuildInputs = [
    installShellFiles
    makeBinaryWrapper
  ];

  buildInputs = lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.SystemConfiguration ];

  preFixup = ''
    mv $out/bin/nh_darwin $out/bin/nh

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

  cargoLock = pins.nh-darwin.cargoLock."Cargo.lock";

  meta = {
    license = lib.licenses.eupl12;
    mainProgram = "nh";
  };
}

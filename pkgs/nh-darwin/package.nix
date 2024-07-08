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
rustPlatform.buildRustPackage {
  pname = "nh-darwin";
  inherit (pins.nh-darwin) version;

  inherit (pins.nh-darwin) src;
  strictDeps = true;

  nativeBuildInputs = [
    installShellFiles
    makeBinaryWrapper
  ];

  buildInputs = lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.SystemConfiguration ];

  doCheck = false; # faster builds

  preFixup = ''
    mkdir completions
    $out/bin/nh_darwin completions --shell bash > completions/nh_darwin.bash
    $out/bin/nh_darwin completions --shell zsh > completions/nh_darwin.zsh
    $out/bin/nh_darwin completions --shell fish > completions/nh_darwin.fish

    installShellCompletion completions/*
  '';

  postFixup = ''
    wrapProgram $out/bin/nh_darwin \
      --prefix PATH : ${
        lib.makeBinPath [
          nix-output-monitor
          nvd
        ]
      }
  '';

  cargoLock.lockFile = "${pins.nh-darwin.src}/Cargo.lock";

  meta = {
    license = lib.licenses.eupl12;
    mainProgram = "nh_darwin";
  };
}

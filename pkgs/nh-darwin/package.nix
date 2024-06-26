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
  p = (lib.importTOML "${pins.nh-darwin.src}/Cargo.toml").package;
in
rustPlatform.buildRustPackage {
  pname = "nh-darwin";
  version = "${p.version}-${pins.nh-darwin.version}";

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
    $out/bin/nh-darwin completions --shell bash > completions/nh-darwin.bash
    $out/bin/nh-darwin completions --shell zsh > completions/nh-darwin.zsh
    $out/bin/nh-darwin completions --shell fish > completions/nh-darwin.fish

    installShellCompletion completions/*
  '';

  postFixup = ''
    wrapProgram $out/bin/nh-darwin \
      --prefix PATH : ${
        lib.makeBinPath [
          nix-output-monitor
          nvd
        ]
      }
  '';

  cargoLock.lockFile = "${pins.nh-darwin.src}/Cargo.lock";

  meta = {
    inherit (p) description homepage;
    license = lib.licenses.eupl12;
    mainProgram = "nh-darwin";
  };
}

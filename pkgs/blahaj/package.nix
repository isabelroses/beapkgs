{
  lib,
  pins,
  rustPlatform,
  stdenv,
  openssl,
  darwin,
  pkg-config,
}:
let
  p = (lib.importTOML "${pins.blahaj.src}/Cargo.toml").package;
in
rustPlatform.buildRustPackage {
  pname = p.name;
  inherit (p) version;

  inherit (pins.blahaj) src;

  cargoLock.lockFile = "${pins.blahaj.src}/Cargo.lock";
  buildInputs =
    [ openssl ]
    ++ lib.optionals stdenv.isDarwin (
      with darwin.apple_sdk.frameworks;
      [
        Security
        CoreFoundation
        SystemConfiguration
      ]
    );

  nativeBuildInputs = [ pkg-config ];

  env = {
    BUILD_REV = p.version;
  };

  meta = {
    inherit (p) description homepage;
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ isabelroses ];
    mainProgram = "blahaj";
  };
}

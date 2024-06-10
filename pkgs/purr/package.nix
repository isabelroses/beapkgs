{
  lib,
  rustPlatform,
  pkg-config,
  openssl,
  stdenv,
  darwin,
  pins,
}:
rustPlatform.buildRustPackage {
  pname = "purr";
  inherit ((lib.importTOML "${pins.purr.src}/Cargo.toml").package) version;

  inherit (pins.purr) src;
  cargoLock.lockFile = "${pins.purr.src}/Cargo.lock";

  nativeBuildInputs = [ pkg-config ];

  buildInputs =
    [ openssl ]
    ++ lib.optionals stdenv.isDarwin (
      with darwin.apple_sdk.frameworks;
      [
        Security
        SystemConfiguration
      ]
    );

  meta = {
    description = "Utility commands for managing userstyles";
    homepage = "https://github.com/uncenter/purr";
    license = lib.licenses.mit;
    mainProgram = "purr";
  };
}

{
  lib,
  pins,
  darwin,
  stdenv,
  openssl,
  pkg-config,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "ringfairy";
  version = builtins.substring 0 7 pins.ringfairy.version;

  inherit (pins.ringfairy) src;
  cargoLock.lockFile = "${pins.ringfairy.src}/Cargo.lock";

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
}

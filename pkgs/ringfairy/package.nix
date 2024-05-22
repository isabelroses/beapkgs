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
  version = builtins.substring 0 7 pins.ringfairy.revision;

  src = pins.ringfairy;
  cargoLock.lockFile = (pins.ringfairy + "/Cargo.lock");

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

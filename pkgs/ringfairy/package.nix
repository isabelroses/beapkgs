{
  lib,
  pins,
  apple-sdk_15,
  stdenv,
  openssl,
  pkg-config,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "ringfairy";
  version = builtins.substring 0 7 pins.ringfairy.version;

  inherit (pins.ringfairy) src;
  cargoLock = pins.ringfairy.cargoLock."Cargo.lock";

  buildInputs = [ openssl ] ++ lib.optional stdenv.hostPlatform.isDarwin apple-sdk_15;

  nativeBuildInputs = [ pkg-config ];

  meta = {
    description = "Build a webring with ease!";
    mainProgram = "ringfairy";
    homepage = "https://github.com/k3rs3d/ringfairy";
    license = lib.licenses.gpl3Plus;
  };
}

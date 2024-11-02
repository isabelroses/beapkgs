{
  lib,
  rustPlatform,
  pkg-config,
  openssl,
  stdenv,
  apple-sdk_15,
  pins,
}:
rustPlatform.buildRustPackage {
  pname = "purr";
  version = builtins.substring 0 7 pins.purr.version;

  inherit (pins.purr) src;
  cargoLock = pins.purr.cargoLock."Cargo.lock";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl ] ++ lib.optional stdenv.hostPlatform.isDarwin apple-sdk_15;

  meta = {
    description = "Utility commands for managing userstyles";
    homepage = "https://github.com/uncenter/purr";
    license = lib.licenses.mit;
    mainProgram = "purr";
  };
}

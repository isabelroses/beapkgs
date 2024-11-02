{
  lib,
  pins,
  rustPlatform,
  stdenv,
  openssl,
  apple-sdk_15,
  pkg-config,
}:
let
  version = builtins.substring 0 7 pins.blahaj.version;
in
rustPlatform.buildRustPackage {
  pname = "blahaj";
  inherit version;

  inherit (pins.blahaj) src;

  cargoLock = pins.blahaj.cargoLock."Cargo.lock";

  buildInputs = [ openssl ] ++ lib.optional stdenv.hostPlatform.isDarwin apple-sdk_15;

  nativeBuildInputs = [ pkg-config ];

  env = {
    BUILD_REV = version;
  };

  meta = {
    description = "the resident discord bot of hell :3";
    homepage = "https://github.com/isabelroses/blahaj";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ isabelroses ];
    mainProgram = "blahaj";
  };
}

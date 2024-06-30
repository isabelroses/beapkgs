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
  version = builtins.substring 0 7 pins.blahaj.version;
in
rustPlatform.buildRustPackage {
  pname = "blahaj";
  inherit version;

  inherit (pins.blahaj) src;

  cargoLock = {
    lockFile = "${pins.blahaj.src}/Cargo.lock";
    outputHashes = {
      "git-tracker-0.2.0" = "sha256-ekji25NfXsMrAQE8uz24DkFcGfba1U2SLTEZE/atpss=";
    };
  };

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

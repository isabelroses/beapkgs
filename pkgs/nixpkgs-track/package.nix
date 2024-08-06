{
  lib,
  pins,
  darwin,
  stdenv,
  openssl,
  pkg-config,
  rustPlatform,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "nixpkgs-track";
  version = builtins.substring 0 7 pins.nixpkgs-track.version;

  inherit (pins.nixpkgs-track) src;
  cargoLock.lockFile = "${pins.nixpkgs-track.src}/Cargo.lock";

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [ SystemConfiguration ]);

  nativeBuildInputs = [ pkg-config ];

  meta = {
    description = "Track where Nixpkgs pull requests have reached";
    homepage = "https://github.com/uncenter/nixpkgs-track";
    license = lib.licenses.mit;
    mainProgram = "nixpkgs-track";
  };
}

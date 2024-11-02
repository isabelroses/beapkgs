{
  lib,
  pins,
  apple-sdk_15,
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
  cargoLock = pins.nixpkgs-track.cargoLock."Cargo.lock";

  buildInputs = [
    openssl
  ] ++ lib.optional stdenv.hostPlatform.isDarwin apple-sdk_15;

  nativeBuildInputs = [ pkg-config ];

  meta = {
    description = "Track where Nixpkgs pull requests have reached";
    homepage = "https://github.com/uncenter/nixpkgs-track";
    license = lib.licenses.mit;
    mainProgram = "nixpkgs-track";
  };
}

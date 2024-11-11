{
  lib,
  pins,
  openssl,
  pkg-config,
  rustPlatform,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "nixpkgs-using";
  version = builtins.substring 0 7 pins.nixpkgs-using.version;

  inherit (pins.nixpkgs-using) src;
  cargoLock = pins.nixpkgs-using.cargoLock."Cargo.lock";

  buildInputs = [ openssl ];

  nativeBuildInputs = [ pkg-config ];

  meta = {
    description = "Find packages that you use that are currently being updated in Nixpkgs";
    homepage = "https://github.com/uncenter/nixpkgs-using";
    license = lib.licenses.mit;
    mainProgram = "nixpkgs-using";
  };
}

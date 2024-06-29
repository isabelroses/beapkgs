{
  lib,
  pins,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "meower";
  version = builtins.substring 0 7 pins.meower.version;

  inherit (pins.meower) src;
  cargoLock.lockFile = "${pins.meower.src}/Cargo.lock";

  meta = {
    description = "Helps you generate your meow mrrrp nya";
    homepage = "https://github.com/Noxyntious/meower";
    mainProgram = "meower";
  };
}

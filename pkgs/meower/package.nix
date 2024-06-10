{
  lib,
  pins,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "meower";
  inherit ((lib.importTOML "${pins.meower.src}/Cargo.toml").package) version;

  inherit (pins.meower) src;
  cargoLock.lockFile = "${pins.meower.src}/Cargo.lock";

  meta = {
    description = "Helps you generate your meow mrrrp nya";
    homepage = "https://github.com/Noxyntious/meower";
    mainProgram = "meower";
  };
}

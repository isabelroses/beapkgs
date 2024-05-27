{
  lib,
  pins,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "meower";
  inherit ((lib.importTOML (pins.meower + "/Cargo.toml")).package) version;

  src = pins.meower;
  cargoLock.lockFile = (pins.meower + "/Cargo.lock");

  meta = {
    description = "Helps you generate your meow mrrrp nya";
    homepage = "https://github.com/Noxyntious/meower";
    mainProgram = "meower";
  };
}

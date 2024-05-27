{
  lib,
  pins,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "ito";
  inherit ((lib.importTOML (pins.ito + "/Cargo.toml")).package) version;

  src = pins.ito;
  cargoLock.lockFile = (pins.ito + "/Cargo.lock");

  meta = {
    description = "A powerful string manipulation tool";
    homepage = "https://github.com/uncenter/ito";
    license = lib.licenses.mit;
    mainProgram = "ito";
  };
}

{
  lib,
  pins,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "ito";
  inherit ((lib.importTOML "${pins.ito.src}/Cargo.toml").package) version;

  inherit (pins.ito) src;
  cargoLock.lockFile = "${pins.ito.src}/Cargo.lock";

  meta = {
    description = "A powerful string manipulation tool";
    homepage = "https://github.com/uncenter/ito";
    license = lib.licenses.mit;
    mainProgram = "ito";
  };
}

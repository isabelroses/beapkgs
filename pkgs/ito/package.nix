{
  lib,
  pins,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "ito";
  version = builtins.substring 0 7 pins.ito.version;

  inherit (pins.ito) src;
  cargoLock.lockFile = "${pins.ito.src}/Cargo.lock";

  meta = {
    description = "A powerful string manipulation tool";
    homepage = "https://github.com/uncenter/ito";
    license = lib.licenses.mit;
    mainProgram = "ito";
  };
}

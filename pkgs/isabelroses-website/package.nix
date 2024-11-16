{
  lib,
  pins,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "isabelroses-website";
  version = builtins.substring 0 7 pins.isabelroses-website.version;

  inherit (pins.isabelroses-website) src;
  cargoLock = pins.isabelroses-website.cargoLock."Cargo.lock";

  meta = {
    description = "isabelroses.com";
    homepage = "https://isabelroses.com/";
    license = with lib.licenses; [
      mit
      cc-by-nc-sa-40
    ];
    mainProgram = "isabelroses-website";
  };
}

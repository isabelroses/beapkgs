{
  lib,
  pins,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "hyfetch";
  version = builtins.substring 0 7 pins.hyfetch.version;

  inherit (pins.hyfetch) src;
  cargoLock = pins.hyfetch.cargoLock."Cargo.lock";

  meta = {
    description = "neofetch with pride flags <3";
    longDescription = ''
      HyFetch is a command-line system information tool fork of neofetch.
      HyFetch displays information about your system next to your OS logo
      in ASCII representation. The ASCII representation is then colored in
      the pattern of the pride flag of your choice. The main purpose of
      HyFetch is to be used in screenshots to show other users what
      operating system or distribution you are running, what theme or
      icon set you are using, etc.
    '';
    homepage = "https://github.com/hykilpikonna/HyFetch";
    license = lib.licenses.mit;
    mainProgram = "hyfetch";
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}

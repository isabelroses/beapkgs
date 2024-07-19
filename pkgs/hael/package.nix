{
  lib,
  pins,
  buildGoModule,
}:
let
  version = builtins.substring 0 7 pins.hael.version;
in
buildGoModule {
  pname = "hael";
  inherit version;

  inherit (pins.hael) src;

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Trans rights are human rights";
    homepage = "https://github.com/isabelroses/hael";
    license = with lib.licenses; [ mit ];
    maintainers = with lib.maintainers; [ isabelroses ];
    mainProgram = "hael";
  };
}

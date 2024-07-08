{
  lib,
  pins,
  buildGoModule,
}:
let
  version = builtins.substring 0 7 pins.isabelroses-website.version;
in
buildGoModule {
  pname = "isabelroses-website";
  inherit version;

  inherit (pins.isabelroses-website) src;

  vendorHash = "sha256-9ZjF2Y5xx0+NARkh1zbTb4igYbCDEGDIMBxJWXOeGvc=";

  ldflags = [
    "-s"
    "-w"
  ];

  patchPhase = ''
    substituteInPlace lib/settings.go \
      --replace-fail 'RootDir string = "."' 'RootDir  string = "'$out/share'"'
  '';

  postInstall = ''
    mkdir -p $out/share

    cp -r content $out/share/content
    cp -r public $out/share/public
    cp -r templates $out/share/templates
  '';

  meta = {
    description = "isabelroses.com";
    homepage = "https://isabelroses.com/";
    license = lib.licenses.mit;
    mainProgram = "isabelroses.com";
  };
}

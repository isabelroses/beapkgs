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

  vendorHash = "sha256-rdAPPF8pqkK/JZSKC2XBmJDzgCh5PA5LJgrg9Z0ZAnU=";

  ldflags = [
    "-s"
    "-w"
  ];

  patchPhase = ''
    substituteInPlace lib/settings.go \
      --replace-fail 'RootDir  string = "."' 'RootDir  string = "'$out/share'"' \
      --replace-fail 'ServeDir string = "."' 'ServeDir string = "/srv/storage/isabelroses.com"'
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
    license = lib.licenses.gpl3;
    mainProgram = "isabelroses.com";
  };
}

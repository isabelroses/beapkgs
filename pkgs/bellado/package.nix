{ pins, rustPlatform }:
rustPlatform.buildRustPackage {
  pname = "bellado";
  version = "0.3.0";

  src = pins.bellado;

  cargoHash = "sha256-N3jH/bjionN6ulxKrzFip2Oyc+cgQEJovxE7UxsDTEA=";

  doCheck = false;
}

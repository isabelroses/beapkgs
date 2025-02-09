{
  lib,
  openssl,
  pkg-config,
  rustPlatform,
  nix-update-script,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nixpkgs-track";
  version = "0.2.0-unstable-2025-01-15";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "nixpkgs-track";
    rev = "b94052fbbd66e299c651cf6c8f6aee951b0fa618";
    hash = "sha256-M3W2qqY1dgrB5Hx+lyP+fRfuXzRiAThaeQaH1A9toBA=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-06cJY13RGXfU8sBy3CooHPK1/2QDI6qfiNcbZV6ZT2o=";

  buildInputs = [ openssl ];
  nativeBuildInputs = [ pkg-config ];

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "Track where Nixpkgs pull requests have reached";
    homepage = "https://github.com/uncenter/nixpkgs-track";
    license = lib.licenses.mit;
    mainProgram = "nixpkgs-track";
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}

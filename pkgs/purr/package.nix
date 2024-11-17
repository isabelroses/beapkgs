{
  lib,
  rustPlatform,
  pkg-config,
  openssl,
  fetchFromGitHub,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "purr";
  version = "1.1.0-unstable-2024-11-12";

  src = fetchFromGitHub {
    owner = "uncenter";
    repo = "purr";
    rev = "e03d3075b4b1ee19148a4902332ffe29dbb39bea";
    hash = "sha256-a5jtJp0r/8iL+E8JhkgdVyKqYQc+uoXpRjf48N1CQ10=";
  };

  cargoHash = "sha256-S5iBteTb8EIm7rzAyWdlQLtdSCyueClHTnIpOYaQmxg=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "Utility commands for managing userstyles";
    homepage = "https://github.com/uncenter/purr";
    license = lib.licenses.mit;
    mainProgram = "purr";
  };
}

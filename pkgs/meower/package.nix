{
  lib,
  rustPlatform,
  nix-update-script,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "meower";
  version = "0.4-unstable-2025-02-10";

  src = fetchFromGitHub {
    owner = "Noxyntious";
    repo = "meower";
    rev = "041fdc0967e97ff041bdb61fff8d6495e2930a77";
    hash = "sha256-Nfu1yZfVx7ZczE9AQxtz9LigGtl1Cq59ser7qho679o=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-6TsB7v1fNV2UI/D/d5u1Q/tO9VGFyYfJi8A49qygi5Q=";

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "Helps you generate your meow mrrrp nya";
    homepage = "https://github.com/Noxyntious/meower";
    mainProgram = "meower";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}

{
  lib,
  rustPlatform,
  nix-update-script,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "meower";
  version = "0.4-unstable-2024-06-15";

  src = fetchFromGitHub {
    owner = "Noxyntious";
    repo = "meower";
    rev = "edc08e7f0f22041d28c70bccd9fd6100e31c1040";
    hash = "sha256-aM69CmZYVRuhuUnAsjojraiv9VXTvhJxIPohw50Qpv8=";
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
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}

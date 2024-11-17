{
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

  cargoHash = "sha256-d0fbtyml6YV1q4SUu1WIA5bLCmEfwkkg4CZrqNuo7L8=";

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
  };
}

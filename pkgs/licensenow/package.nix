{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:
buildGoModule {
  pname = "licencenow";
  version = "0.1.0-unstable-2024-03-21";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "licencenow";
    rev = "a03dcc4158acad6359f78ef2dfefe0cfcb74ed8b";
    hash = "sha256-wYqXagPThOqBxQfXyhCi1y5hm/yGxT4QrqbZW62lWQE=";
  };

  vendorHash = "sha256-aVk0ccByDS4+gs2im4eU6S5daK3OVoRYoBxn3SSgDGw=";

  ldflags = [
    "-s"
    "-w"
  ];

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "licencenow gets you a license for your project";
    homepage = "https://github.com/isabelroses/licencenow";
    license = with lib.licenses; [ mit ];
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}

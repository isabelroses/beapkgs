{
  lib,
  rustPlatform,
  fastfetch,
  makeWrapper,
  nix-update-script,
  fetchFromGitHub,
  backends ? [ fastfetch ],
}:
rustPlatform.buildRustPackage {
  pname = "hyfetch";
  version = "2.0.0-rc1-unstable-2025-01-18";

  src = fetchFromGitHub {
    owner = "hykilpikonna";
    repo = "hyfetch";
    rev = "5ec7b4f01a1958a9c24c4a19eece0ca6189b9714";
    hash = "sha256-Xpl9y2pYoiUjZ49B03DiFrL3WRvqQuhDdoZSR8LGzMA=";
  };

  cargoHash = "sha256-Rxy1lBs/Q0JnuM5CrSlfFkymmYC/ZC10I5xzZM6fgPQ=";

  nativeBuildInputs = [ makeWrapper ];

  postFixup = ''
    wrapProgram $out/bin/hyfetch \
      --suffix PATH : ${lib.makeBinPath backends}
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "neofetch with pride flags <3";
    longDescription = ''
      HyFetch is a command-line system information tool fork of neofetch.
      HyFetch displays information about your system next to your OS logo
      in ASCII representation. The ASCII representation is then colored in
      the pattern of the pride flag of your choice. The main purpose of
      HyFetch is to be used in screenshots to show other users what
      operating system or distribution you are running, what theme or
      icon set you are using, etc.
    '';
    homepage = "https://github.com/hykilpikonna/HyFetch";
    license = lib.licenses.mit;
    mainProgram = "hyfetch";
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}

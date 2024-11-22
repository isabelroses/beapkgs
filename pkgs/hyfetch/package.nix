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
  version = "1.99.0-unstable-2024-11-22";

  src = fetchFromGitHub {
    owner = "hykilpikonna";
    repo = "hyfetch";
    rev = "bb260890c5d2ad8bba6cb1fa5156d786caf562da";
    hash = "sha256-WzEbOGuyqV/9E3wlcZJk/HIHQe5zAz3qp+pJAtL+/LQ=";
  };

  cargoHash = "sha256-dK5gjenmTQiproVovI4c1iwogtSX/xCsTOAhEB51A4o=";

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

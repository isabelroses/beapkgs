{
  lib,
  git,
  pins,
  gtk3,
  sassc,
  python3,
  stdenvNoCC,
  gtk-engine-murrine,
  gnome-themes-extra,
  accents ? [ "mauve" ],
  size ? "standard",
  tweaks ? [ ],
  variant ? "mocha",
}:
let
  validAccents = [
    "blue"
    "flamingo"
    "green"
    "lavender"
    "maroon"
    "mauve"
    "peach"
    "pink"
    "red"
    "rosewater"
    "sapphire"
    "sky"
    "teal"
    "yellow"
  ];
  validSizes = [
    "standard"
    "compact"
  ];
  validTweaks = [
    "black"
    "rimless"
    "normal"
    "float"
    "oled"
  ];
  validVariants = [
    "latte"
    "frappe"
    "macchiato"
    "mocha"
  ];

  pname = "catppuccin-gtk";
  version = builtins.substring 0 7 pins.gtk.revision;
in

lib.checkListOfEnum "${pname}: theme accent" validAccents accents

  lib.checkListOfEnum
  "${pname}: color variant"
  validVariants
  [ variant ]

  lib.checkListOfEnum
  "${pname}: size variant"
  validSizes
  [ size ]

  lib.checkListOfEnum
  "${pname}: tweaks"
  validTweaks
  tweaks

  stdenvNoCC.mkDerivation
  {
    inherit pname version;

    src = pins.gtk;

    nativeBuildInputs = [
      git
      gtk3
      sassc
    ];

    buildInputs = [
      gnome-themes-extra
      (python3.withPackages (ps: [ ps.catppuccin ]))
    ];

    propagatedUserEnvPkgs = [ gtk-engine-murrine ];

    postUnpack = ''
      rm -rf source/colloid
      cp -r ${pins.colloid-gtk-theme} source/colloid
      chmod -R +w source/colloid
    '';

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/themes

      python3 build.py ${variant} \
        --accent ${builtins.toString accents} \
        ${lib.optionalString (size != [ ]) "--size " + size} \
        ${lib.optionalString (tweaks != [ ]) "--tweaks " + builtins.toString tweaks} \
        --dest $out/share/themes

      runHook postInstall
    '';

    meta = {
      description = "Soothing pastel theme for GTK";
      homepage = "https://github.com/catppuccin/gtk";
      license = lib.licenses.gpl3Plus;
      platforms = lib.platforms.linux;
    };
  }

{
  lib,
  stdenv,
  fetchurl,
  wrapGAppsHook4,
  makeWrapper,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  cairo,
  cups,
  dbus,
  dpkg,
  expat,
  fontconfig,
  freetype,
  gdk-pixbuf,
  glib,
  adwaita-icon-theme,
  gsettings-desktop-schemas,
  gtk3,
  gtk4,
  libdrm,
  libxkbcommon,
  mesa,
  nspr,
  nss,
  pango,
  pipewire,
  snappy,
  udev,
  wayland,
  xdg-utils,
  coreutils,
  libuuid,
  xorg,
  zlib,
  widevine-cdm,
  qt6,
  libkrb5,
  vivaldi-ffmpeg-codecs,

  # command line arguments which are always set e.g "--disable-gpu"
  commandLineArgs ? "",

  # Necessary for USB audio devices.
  pulseSupport ? stdenv.hostPlatform.isLinux,
  libpulseaudio,

  # For GPU acceleration support on Wayland (without the lib it doesn't seem to work)
  libGL,

  # For video acceleration via VA-API (--enable-features=VaapiVideoDecoder,VaapiVideoEncoder)
  libvaSupport ? stdenv.isLinux,
  libva,

  enableVideoAcceleration ? libvaSupport,

  # For Vulkan support (--enable-features=Vulkan); disabled by default as it seems to break VA-API
  vulkanSupport ? true,
  addOpenGLRunpath,
  enableVulkan ? vulkanSupport,

  enableWideVine ? false,
}:
let
  inherit (lib)
    optional
    optionals
    makeLibraryPath
    makeSearchPathOutput
    makeBinPath
    optionalString
    strings
    escapeShellArg
    ;

  deps = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    gtk4
    libdrm
    libGL
    libxkbcommon
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libxshmfence
    xorg.libXtst
    xorg.libxcb
    xorg.libX11
    libuuid
    mesa
    nspr
    nss
    pango
    pipewire
    udev
    wayland
    zlib
    snappy
    libkrb5
    vivaldi-ffmpeg-codecs
  ] ++ optional pulseSupport libpulseaudio ++ optional libvaSupport libva;

  rpath = makeLibraryPath deps + ":" + makeSearchPathOutput "lib" "lib64" deps;
  binpath = makeBinPath deps;

  enableFeatures =
    optionals enableVideoAcceleration [
      "VaapiVideoDecoder"
      "VaapiVideoEncoder"
    ]
    ++ optional enableVulkan "Vulkan";

  disableFeatures = [
    "OutdatedBuildDetector"
  ] ++ optional enableVideoAcceleration "UseChromeOSDirectVideoDecoder";

  version = "128.0.6613.189";
in
stdenv.mkDerivation {
  pname = "thorium";
  inherit version;

  src = fetchurl {
    url = "https://github.com/Alex313031/thorium/releases/download/M${version}/thorium-browser_${version}_AVX2.deb";
    hash = "sha256-oid72E4n9jAQsCUrztlyj56Gd0+pz735y6b5COMA4tg=";
  };

  dontConfigure = true;
  dontBuild = true;
  dontPatchELF = true;
  doInstallCheck = true;

  nativeBuildInputs = [
    dpkg
    (wrapGAppsHook4.override { inherit makeWrapper; })
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    glib
    gsettings-desktop-schemas
    gtk3
    gtk4
    qt6.qtbase
    qt6.qtwayland

    # needed for XDG_ICON_DIRS
    adwaita-icon-theme
  ];

  unpackPhase = "dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner";

  installPhase =
    ''
      runHook preInstall

      mkdir -p $out $out/bin

      cp -R usr/share $out
      cp -R opt/ $out/opt

      export BINARYWRAPPER=$out/opt/chromium.org/thorium/thorium-browser

      # Fix path to bash in $BINARYWRAPPER
      substituteInPlace $BINARYWRAPPER \
          --replace /bin/bash ${stdenv.shell}

      ln -sf $BINARYWRAPPER $out/bin/thorium

      for exe in $out/opt/chromium.org/thorium/{thorium,chrome_crashpad_handler}; do
          patchelf \
              --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
              --set-rpath "${rpath}" $exe
      done

       # Fix paths
      substituteInPlace $out/share/applications/thorium-browser.desktop \
          --replace-fail /usr/bin/thorium-browser $out/bin/thorium
      substituteInPlace $out/share/gnome-control-center/default-apps/thorium-browser.xml \
          --replace-fail /opt/chromium.org $out/opt/chromium.org
      substituteInPlace $out/share/menu/thorium-browser.menu \
          --replace-fail /opt/chromium.org $out/opt/chromium.org
      substituteInPlace $out/opt/chromium.org/thorium/default-app-block \
          --replace-fail /opt/chromium.org $out/opt/chromium.org

      # Correct icons location
      icon_sizes=("16" "24" "32" "48" "64" "128" "256")

      for icon in ''${icon_sizes[*]}
      do
        mkdir -p $out/share/icons/hicolor/$icon\x$icon/apps
        ln -s $out/opt/chromium.org/thorium/product_logo_$icon.png $out/share/icons/hicolor/$icon\x$icon/apps/thorium-browser.png
      done

      # Replace xdg-settings and xdg-mime
      ln -sf ${xdg-utils}/bin/xdg-settings $out/opt/chromium.org/thorium/xdg-settings
      ln -sf ${xdg-utils}/bin/xdg-mime $out/opt/chromium.org/thorium/xdg-mime
    ''
    + lib.optionalString enableWideVine ''
      ln -sf ${widevine-cdm}/share/google/chrome/WidevineCdm $out/opt/chromium.org/thorium/WidevineCdm
    ''
    + ''
      runHook postInstall
    '';

  preFixup = ''
    # Add command line args to wrapGApp.
    gappsWrapperArgs+=(
      --prefix LD_LIBRARY_PATH : ${rpath}
      --prefix PATH : ${binpath}
      --suffix PATH : ${
        lib.makeBinPath [
          xdg-utils
          coreutils
        ]
      }
      ${
        optionalString (enableFeatures != [ ]) ''
          --add-flags "--enable-features=${strings.concatStringsSep "," enableFeatures}"
        ''
      }
      ${
        optionalString (disableFeatures != [ ]) ''
          --add-flags "--disable-features=${strings.concatStringsSep "," disableFeatures}"
        ''
      }
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
      ${optionalString vulkanSupport ''
        --prefix XDG_DATA_DIRS  : "${addOpenGLRunpath.driverLink}/share"
      ''}
      --add-flags ${escapeShellArg commandLineArgs}
    )
  '';

  installCheckPhase = ''
    # Bypass upstream wrapper which suppresses errors
    $out/opt/chromium.org/thorium/thorium --version
  '';

  meta = {
    description = "Compiler-optimized private Chromium fork";
    homepage = "https://thorium.rocks/index.html";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.bsd3;
    platforms = [ "x86_64-linux" ];
  };
}

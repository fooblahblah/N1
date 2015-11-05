with import <nixpkgs> {}; let
  runtimeLibs = [ dbus glib gnome.gtk gnome.pango atk cairo freetype fontconfig gdk_pixbuf
                  xorg.libX11 xorg.libXrandr xorg.libXext xorg.libXi xorg.libXcursor xorg.libXfixes
		  xorg.libXrender xorg.libXcomposite xorg.libXdamage xorg.libXtst
		  gnome.GConf nss nspr alsaLib cups expat libcap systemd ];
  libPaths    = map (x: ":${x}/lib") runtimeLibs;
in rec {
  N1Env = stdenv.mkDerivation {
    name        = "N1";
    buildInputs = [ stdenv cmake pkgconfig libgnome_keyring nodejs python ];
    LD_LIBRARY_PATH="${stdenv.cc.cc}/lib" + lib.foldl (x: y: x + y) "" libPaths;
  };
}

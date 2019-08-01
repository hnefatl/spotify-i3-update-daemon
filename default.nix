{ pkgs, stdenv }:

stdenv.mkDerivation {
    name = "spotify-i3-update-daemon";

    phases = [ "installPhase" "fixupPhase" ];

    nativeBuildInputs = [ pkgs.makeWrapper ];
    buildInputs = [
        pkgs.playerctl
        pkgs.gobject-introspection
        pkgs.dbus
        pkgs.procps
        (pkgs.python3.withPackages (ps: [ ps.pygobject3 ]))
    ];

    installPhase = ''
        mkdir -p $out/bin
        cp ${./spotify-i3-update-daemon} $out/bin/spotify-i3-update-daemon
        wrapProgram $out/bin/spotify-i3-update-daemon \
            --set GI_TYPELIB_PATH ${pkgs.playerctl}/lib/girepository-1.0 \
            --prefix PATH ":" ${pkgs.dbus}/bin \
            --prefix PATH ":" ${pkgs.procps}/bin
    '';
}
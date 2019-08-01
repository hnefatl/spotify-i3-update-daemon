{ pkgs, stdenv }:

stdenv.mkDerivation {
    name = "spotify-i3-update-daemon";

    phases = [ "installPhase" "fixupPhase" ];

    installPhase = "mkdir -p $out/bin && cp ${./spotify-i3-update-daemon} $out/bin/spotify-i3-update-daemon";
}
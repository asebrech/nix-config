{ lib, pkgs, ... }:
{
  home.packages = lib.attrValues {
    inherit (pkgs)
      obs-studio
      vlc
      ;
  };

  # VLC as the default player for music and video
  xdg.mimeApps.defaultApplications =
    let
      audio = [
        "audio/mpeg"
        "audio/mp4"
        "audio/aac"
        "audio/flac"
        "audio/ogg"
        "audio/opus"
        "audio/x-vorbis+ogg"
        "audio/x-wav"
      ];
      video = [
        "video/mp4"
        "video/mpeg"
        "video/webm"
        "video/quicktime"
        "video/x-matroska"
        "video/x-msvideo"
        "video/ogg"
      ];
    in
    lib.genAttrs (audio ++ video) (_: [ "vlc.desktop" ]);
}

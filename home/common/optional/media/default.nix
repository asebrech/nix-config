{ lib, pkgs, ... }:
{
  home.packages = lib.attrValues {
    inherit (pkgs)
      obs-studio
      vlc
      loupe # GNOME image viewer (GTK4)
      ;
  };

  # VLC for audio/video, loupe for images
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
      image = [
        "image/png"
        "image/jpeg"
        "image/gif"
        "image/webp"
        "image/bmp"
        "image/tiff"
        "image/svg+xml"
      ];
    in
    lib.genAttrs (audio ++ video) (_: [ "vlc.desktop" ])
    // lib.genAttrs image (_: [ "org.gnome.Loupe.desktop" ]);
}

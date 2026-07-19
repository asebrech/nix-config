#
# greetd auto-login: boots straight into the niri session, no greeter UI.
# The LUKS passphrase at boot is the real gate on this single-user
# encrypted laptop; the running session is protected by the noctalia
# lock screen (idle timeout, suspend, session menu).
#
{ config, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "niri-session";
        user = config.hostSpec.primaryUsername;
      };
    };
  };
}

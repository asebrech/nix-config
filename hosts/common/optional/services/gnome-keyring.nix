{
  # GNOME Keyring itself is enabled by the niri module. This file only
  # adjusts it: disable the conflicting ssh agent and unlock via PAM.

  # gnome-keyring pulls in gcr-ssh-agent by default, which conflicts with
  # programs.ssh.startAgent defined in core/ssh.nix. Disable it explicitly
  # so the existing openssh agent is used for SSH key management instead.
  services.gnome.gcr-ssh-agent.enable = false;

  # Keyring PAM hook on greetd. NOTE: with auto-login no password is typed
  # at session start, so the keyring cannot be unlocked automatically; it
  # prompts on first use (or give it an empty password — data at rest is
  # already protected by full-disk encryption).
  security.pam.services.greetd.enableGnomeKeyring = true;
}

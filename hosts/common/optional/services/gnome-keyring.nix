{
  # GNOME Keyring itself is enabled by the COSMIC module. This file only
  # adjusts it: disable the conflicting ssh agent and unlock via PAM.

  # gnome-keyring pulls in gcr-ssh-agent by default, which conflicts with
  # programs.ssh.startAgent defined in core/ssh.nix. Disable it explicitly
  # so the existing openssh agent is used for SSH key management instead.
  services.gnome.gcr-ssh-agent.enable = false;

  # Unlock the keyring automatically when cosmic-greeter authenticates the
  # user. Targeting cosmic-greeter (not login) since that is the active
  # display manager.
  security.pam.services.cosmic-greeter.enableGnomeKeyring = true;
}

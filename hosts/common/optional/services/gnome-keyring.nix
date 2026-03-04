{
  # GNOME Keyring provides a libsecret-compatible daemon for storing
  # credentials, tokens, and secrets used by desktop applications.
  services.gnome.gnome-keyring.enable = true;

  # gnome-keyring pulls in gcr-ssh-agent by default, which conflicts with
  # programs.ssh.startAgent defined in core/ssh.nix. Disable it explicitly
  # so the existing openssh agent is used for SSH key management instead.
  services.gnome.gcr-ssh-agent.enable = false;

  # Unlock the keyring automatically when greetd authenticates the user.
  # Targeting greetd (not login) since that is the active display manager.
  security.pam.services.greetd.enableGnomeKeyring = true;
}

# git is core no matter what but additional settings may could be added made in optional/foo   eg: development.nix
{
  pkgs,
  config,
  ...
}:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    ignores = [
      ".csvignore"
      # nix
      "*.drv"
      "result"
      # python
      "*.py?"
      "__pycache__/"
      ".venv/"
      # direnv
      ".direnv"
    ];

    settings = {
      user = {
        name = config.hostSpec.handle;
        email = config.hostSpec.email.personal or config.hostSpec.email.main or "";
      };
    };

  };

}

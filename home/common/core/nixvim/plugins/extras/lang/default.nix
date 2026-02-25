# lang extras
{ ... }:
{
  imports = [
    ./nix.nix
    ./python.nix
    ./typescript.nix
    ./markdown.nix
    ./rust.nix
    ./go.nix
  ];
}

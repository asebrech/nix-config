<div align="center">
<h1>
<img width="100" src="docs/nixos-ascendancy.png" /> <br>
</h1>
</div>

# EmergentMind's Nix-Config Starter


> [!WARNING]
> **THIS REPO IS STILL WIP FOR USE EVEN AS A STARTER**


## Table of Contents

- [Secrets Management](#secrets-management)
- [Support](#support)
- [Guidance and Resources](#guidance-and-resources)
- [Acknowledgements](#acknowledgements)

---

Watch NixOS related videos on my [YouTube channel](https://www.youtube.com/@Emergent_Mind).
Chat with me directly on our [Discord server](https://discord.gg/XTFg57xGxC).

## Secrets Management

Secrets for this config are stored in a private repository called `nix-secrets` that is pulled in as a flake input and managed using the sops-nix tool.

For details on how this is accomplished, how to approach different scenarios, and troubleshooting for some common hurdles, please see my article and accompanying YouTube video [NixOS Secrets Management](https://unmovedcentre.com/posts/secrets-management/) available on my website. There is also a [nix-secrets-reference](https://github.com/EmergentMind/nix-secrets-reference) repository that can be used in conjunction with the article.

## Support

Sincere thanks to all of my generous supporters!

If you find what I do helpful, please consider supporting my work using one of the links under "Sponsor this project" on the right-hand column of this page.

I intentionally keep all of my content ad-free but some platforms, such as YouTube, put ads on my videos outside of my control.

## Guidance and Resources

- [NixOS.org Manuals](https://nixos.org/learn/)
- [Official Nix Documentation](https://nix.dev)
  - [Best practices](https://nix.dev/guides/best-practices)
- [Noogle](https://noogle.dev/) - Nix API reference documentation.
- [Official NixOS Wiki](https://wiki.nixos.org/)
- [NixOS Package Search](https://search.nixos.org/packages)
- [NixOS Options Search](https://search.nixos.org/options?)
- [Home Manager Option Search](https://home-manager-options.extranix.com/)
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/) - an excellent introductory book by Ryan Yin

## Acknowledgements

Those who have heavily influenced this strange journey into the unknown.

- [FidgetingBits](https://github.com/fidgetingbits) - You told me there was a strange door that could be opened. I'm truly grateful.
- [Mic92](https://github.com/Mic92) and [Lassulus](https://github.com/Lassulus) - My nix-config leverages many of the fantastic tools that these two people maintain, such as sops-nix, disko, and nixos-anywhere.
- [Misterio77](https://github.com/Misterio77) - Structure and reference.
- [Ryan Yin](https://github.com/ryan4yin/nix-config) - A treasure trove of useful documentation and ideas.
- [VimJoyer](https://github.com/vimjoyer) - Excellent videos on the high-level concepts required to navigate NixOS.

---

[Return to top](#emergentminds-nix-config-starter)

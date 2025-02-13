{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  # todo remove flake parts dependency
  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      imports = [];
      flake = {};

      perSystem = { config, self', inputs', pkgs, system, ... }: let
        nvimConfig = pkgs.callPackage ./nvimConfig.nix {};
        nvim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped nvimConfig;
        paths = [
          nvim
          pkgs.nixd
          pkgs.lua-language-server
          pkgs.rust-analyzer
          pkgs.fzf
          pkgs.ripgrep
          pkgs.wl-clipboard
          pkgs.fd
        ];

        # we don't have to wrap the PATH if installed on nixos I think
        nvimPathsOnly = pkgs.symlinkJoin {
          name = "nvim";
          inherit paths;
        };

        nvimWrapped = pkgs.symlinkJoin {
          name = "nvim";
          inherit paths;

          buildInputs = [
            pkgs.makeWrapper
          ];

          postBuild = ''
            wrapProgram $out/bin/nvim \
              --prefix PATH : "$out/bin"
          '';
        };
      in {
        packages.nvim = nvim;
        packages.nvim-lsp = nvimPathsOnly;
        packages.nvim-lsp-wrapped = nvimWrapped;
        packages.default = nvimWrapped;
      };
    };
}

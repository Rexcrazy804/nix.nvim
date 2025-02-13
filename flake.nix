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
        nvimWrapped = pkgs.symlinkJoin {
          name = "nvim";
          paths = [
            nvim
            pkgs.nixd
            pkgs.lua-language-server
          ];

          buildInputs = [
            pkgs.makeWrapper
          ];

          postBuild = ''
            wrapProgram $out/bin/nvim \
              --prefix PATH : "$out/bin"
          '';
        };
      in {
        packages.default = nvimWrapped;
      };
    };
}

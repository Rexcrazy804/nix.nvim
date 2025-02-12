{ 
  neovimUtils,
  vimPlugins
}: neovimUtils.makeNeovimConfig {
  withPython3 = false;
  withRuby = false;
  withNodejs = false;

  customRC = ''
    :luafile ${./init.lua}
  '';

  plugins = builtins.attrValues {
    inherit (vimPlugins)
      lze
      catppuccin-nvim
      neo-tree-nvim
      nvim-web-devicons
      which-key-nvim
      toggleterm-nvim
      lualine-nvim
    ;
  };
}

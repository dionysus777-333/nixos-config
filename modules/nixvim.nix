{ inputs, pkgs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs.nixvim = {
    enable = true;

    # --- Basic Neovim Options (QOL Improvements) ---
    opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers (great for motions)
      shiftwidth = 2;        # Use 1 spaces for indent
      tabstop = 2;           # Tab width
      expandtab = true;      # Use spaces instead of tabs
      smartindent = true;    # Auto-indenting
      cpoptions = "I";
      autoindent = true;
      breakindent = true;
      mouse = "a";           # Enable mouse support
      ignorecase = true;     # Case-insensitive search
      smartcase = true;      # ...until you use a capital letter
      cursorline = true;     # Highlight the line the cursor is on
      termguicolors = true;  # Enable 24-bit RGB colors
    };

    plugins = {
      # UI & Navigation
      lualine.enable = true;
      neo-tree.enable = true;
      telescope.enable = true;
      which-key.enable = true;

      # Better Highlighting
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          indent.enable = true; # Add this!
          highlight.enable = true;
        };
      };

      # LSP & Completion
      lsp = {
        enable = true;
        servers.nil_ls.enable = true; # Nix LSP
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
      };

      # QOL Plugins
      gitsigns.enable = true;
      autoclose.enable = true;
      comment.enable = true; 
      illuminate.enable = true; # Highlight other uses of word under cursor 
      todo-comments.enable = true;
      indent-blankline.enable = true;
    };                                                                         
  };
}

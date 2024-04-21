{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.git = {
    enable = true;
    userName = "soulsoiledit";
    userEmail = "soulsoill@proton.me";

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };

  programs.lazygit = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.helix = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    withNodeJs = true;

    colorscheme = "catppuccin";

    extraPackages = with pkgs; [
      nodePackages.prettier
      stylua
      shfmt

      google-java-format
      ormolu
      clang-tools
    ];

    extraPlugins = with pkgs.vimPlugins; [
      dressing-nvim
      aerial-nvim
    ];

    opts = {
      autowrite = true;
      undofile = true;
      undolevels = 10000;
      relativenumber = true;

      expandtab = true;
      shiftwidth = 2;
      softtabstop = 2;
      shiftround = true;

      ignorecase = true;
      smartcase = true;

      timeoutlen = 250;

      cursorline = true;
      list = true;
      scrolloff = 4;
      showmode = false;

      splitbelow = true;
      splitright = true;

      autochdir = true;

      wrap = true;
    };

    globals = {
      mapleader = " ";
      localleader = "\\";
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    keymaps = [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = "function() require('flash').jump() end";
        lua = true;
      }

      {
        mode = "o";
        key = "r";
        action = "function() require('flash').remote() end";
        lua = true;
      }

      {
        mode = [
          "n"
          "x"
        ];
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          expr = true;
          silent = true;
        };
      }

      {
        mode = [
          "n"
          "x"
        ];
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          expr = true;
          silent = true;
        };
      }

      # clear on escape
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>noh<CR>";
      }

      {
        mode = "n";
        key = "<leader>g";
        lua = true;
        action = ''
          function()
            require('toggleterm.terminal').Terminal:new({direction='float',cmd='lazygit',hidden=true}):toggle()
          end
        '';
        options = {
          desc = "lazygit";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>fF";
        lua = true;
        action = ''
          function()
            require('telescope.builtin').find_files({hidden = true,no_ignore = true,follow = true})
          end
        '';
        options = {
          desc = "find all files";
        };
      }

      # TODO: add buffer/window maps
      # buffers/windows
    ];

    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          integrations = {
            aerial = true;
            cmp = true;
            dashboard = true;
            gitsigns = true;
            noice = true;
            notify = true;
            semantic_tokens = true;
            symbols_outline = true;
            treesitter_context = true;
            which_key = true;
          };
        };
      };
    };

    plugins = {
      # treesitter
      treesitter = {
        enable = true;
        indent = true;
        nixvimInjections = true;
        incrementalSelection.enable = true;
      };

      treesitter-context = {
        enable = true;
        maxLines = 4;
      };

      treesitter-textobjects = {
        enable = true;
        lspInterop.enable = true;
      };

      ts-autotag.enable = true;
      ts-context-commentstring.enable = true;

      # lsp
      lsp = {
        enable = true;

        keymaps = {
          diagnostic = { };
          lspBuf = {
            K = "hover";
            gd = "definition";
            gD = "type_definition";
            gI = "implementation";
            gR = "references";

            "<leader>ca" = "code_action";
            gr = "rename";
          };
        };

        servers = {
          nil_ls = {
            enable = true;
            settings.formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
            extraOptions = {
              nix.flake.autoArchive = true;
            };
          };

          lua-ls.enable = true;

          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };

          pylsp = {
            enable = true;
            package = pkgs.python3Packages.python-lsp-server;
            settings.plugins.ruff.enabled = true;
          };
          # pylyzer.enable = true;
          ruff.enable = true;

          bashls.enable = true;
          marksman.enable = true;
          ltex.enable = true;

          tsserver.enable = true;
          cssls.enable = true;
          eslint.enable = true;
          html.enable = true;

          jsonls.enable = true;
          yamlls.enable = true;
          taplo.enable = true;

          zls.enable = true;
          # hls.enable = true;
          java-language-server.enable = true;
          clangd.enable = true;
        };
      };

      nix.enable = true;

      # editing
      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "calc"; }
          ];

          mapping = {
            "<C-n>" = ''cmp.mapping.select_next_item()'';
            "<C-p>" = ''cmp.mapping.select_prev_item()'';
            "<C-b>" = ''cmp.mapping.scroll_docs(-4)'';
            "<C-f>" = ''cmp.mapping.scroll_docs(4)'';
            "<C-Space>" = ''cmp.mapping.complete()'';
            "<C-e>" = ''cmp.mapping.abort()'';
            "<CR>" = ''cmp.mapping.confirm({cmp.ConfirmBehavior.Insert, select = true })'';

            "<Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.confirm({ select = true })
                elseif require("luasnip").expand_or_jumpable() then
                  require("luasnip").expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" })'';

            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").jumpable(-1) then
                  require("luasnip").jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })'';
          };
        };
      };

      # efm-lsp
      # none-ls

      luasnip.enable = true;
      friendly-snippets.enable = true;

      mini = {
        enable = true;
        modules = {
          ai = { };
          align = { };
          # basics = {};
          bracketed = { };
          comment = { };
          cursorword = { };
          pairs = { };
          surround = {
            mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";
            };
          };
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<leader>t]]";
          insert_mappings = false;
          autochdir = true;
        };
      };

      # navigation
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fs" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fa" = "find_files";
          "<leader>fr" = "oldfiles";

          "<leader>fc" = "commands";
          "<leader>fe" = "command_history";
          "<leader>fh" = "help_tags";
          "<leader>fm" = "marks";

          "<leader>fgc" = "git_commits";
          "<leader>fgs" = "git_status";

          "<leader>ld" = "lsp_document_symbols";
          "<leader>lw" = "lsp_workspace_symbols";

          "<leader>fp" = "planets";
        };
        extensions = {
          fzf-native.enable = true;
        };
      };

      flash.enable = true;
      nvim-tree.enable = true;
      lastplace.enable = true;

      # formatting / linting
      conform-nvim = {
        enable = true;

        formatOnSave = {
          lspFallback = true;
          timeoutMs = 500;
        };

        formattersByFt = {
          lua = [ "stylua" ];
          java = [ "google-java-format" ];
          haskell = [ "ormolu" ];
          sh = [ "shfmt" ];

          javascript = [ "prettier" ];
          javascriptreact = [ "prettier" ];
          typescript = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          css = [ "prettier" ];
          scss = [ "prettier" ];
          html = [ "prettier" ];
          json = [ "prettier" ];
          yaml = [ "prettier" ];
        };
      };

      # ui
      noice.enable = true;
      notify.enable = true;

      bufferline.enable = true;
      lualine.enable = true;
      # dashboard.enable = true;
      alpha = {
        enable = true;
        theme = "dashboard";
      };

      which-key.enable = true;

      indent-blankline.enable = true;
      rainbow-delimiters.enable = true;
      todo-comments = {
        enable = true;
        keymaps = {
          todoTelescope.key = "<leader>ft";
          todoQuickFix.key = "<leader>fT";
        };
      };

      nvim-lightbulb = {
        enable = true;
        settings = {
          autocmd.enabled = true;
          sign.text = "󰌵";
        };
      };

      yanky = {
        enable = true;
        highlight.timer = 125;
      };

      # git

      gitsigns.enable = true;
    };
  };
}

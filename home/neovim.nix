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
      lsp-inlayhints-nvim
    ];

    extraConfigLua = ''
      local signs = {
        Error = " ",
        Warn  = " ",
        Hint  = "󰌶 ",
        Info  = " ",
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    '';

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
        options.desc = "flash search";
      }
      {
        mode = "o";
        key = "r";
        action = "function() require('flash').remote() end";
        lua = true;
        options.desc = "flash remote";
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
      {
        # clear on escape
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
        key = "<leader>ff";
        lua = true;
        action = ''
          function()
            local opts = {}

            local builtin = require('telescope.builtin')
            local cwd = vim.fn.getcwd()
            local is_inside_work_tree = {}

            vim.fn.system("git rev-parse --is-inside-work-tree")
            is_inside_work_tree[cwd] = vim.v.shell_error == 0

            if is_inside_work_tree[cwd] then
              builtin.git_files(opts)
            else
              builtin.find_files(opts)
            end
          end
        '';
        options.desc = "files";
      }
      {
        mode = "n";
        key = "<leader>fa";
        lua = true;
        action = ''
          function()
            require('telescope.builtin').find_files({
              hidden = true,
              no_ignore = true
            })
          end
        '';
        options = {
          desc = "all files";
        };
      }
      {
        mode = "n";
        key = "<leader>fS";
        lua = true;
        action = ''
          function()
            require('telescope.builtin').live_grep({
              grep_open_files = true
            })
          end
        '';
        options = {
          desc = "current file grep";
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
      lsp-lines.enable = true;

      lsp = {
        enable = true;

        keymaps = {
          diagnostic = { };
          extra = [
            {
              mode = [
                "n"
                "v"
              ];
              key = "<leader>la";
              lua = true;
              action = "vim.lsp.buf.code_action";
              options.desc = "code action";
            }
            {
              mode = [ "n" ];
              key = "gr";
              lua = true;
              action = "vim.lsp.buf.rename";
              options.desc = "rename";
            }
            {
              mode = [ "n" ];
              key = "gd";
              lua = true;
              action = "require('telescope.builtin').lsp_definitions";
              options.desc = "definition";
            }
            {
              mode = [ "n" ];
              key = "gld";
              lua = true;
              action = "vim.lsp.buf.declaration";
              options.desc = "declaration";
            }
            {
              mode = [ "n" ];
              key = "K";
              lua = true;
              action = "vim.lsp.buf.hover";
              options.desc = "hover";
            }
            {
              mode = [ "n" ];
              key = "gD";
              lua = true;
              action = "require('telescope.builtin').lsp_type_definitions";
              options.desc = "type definition";
            }
            {
              mode = [ "n" ];
              key = "gI";
              lua = true;
              action = "require('telescope.builtin').lsp_implementations";
              options.desc = "implementation";
            }
            {
              mode = [ "n" ];
              key = "gR";
              lua = true;
              action = "require('telescope.builtin').lsp_references";
              options.desc = "references";
            }
            {
              mode = [ "n" ];
              key = "<leader>ld";
              lua = true;
              action = "require('telescope.builtin').lsp_document_symbols";
              options.desc = "file symbols";
            }
            {
              mode = [ "n" ];
              key = "<leader>lw";
              lua = true;
              action = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
              options.desc = "project symbols";
            }
          ];
        };

        servers = {
          nil_ls = {
            enable = true;
            settings.formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
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

          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';

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
          "<leader>fs" = {
            action = "live_grep";
            options.desc = "live grep";
          };
          "<leader>fb" = {
            action = "buffers";
            options.desc = "buffers";
          };
          "<leader>fr" = {
            action = "oldfiles";
            options.desc = "recent files";
          };
          "<leader>fc" = {
            action = "commands";
            options.desc = "commands";
          };
          "<leader>fe" = {
            action = "command_history";
            options.desc = "command history";
          };
          "<leader>fh" = {
            action = "help_tags";
            options.desc = "help";
          };
          "<leader>fk" = {
            action = "keymaps";
            options.desc = "keymaps";
          };
          "<leader>fm" = {
            action = "marks";
            options.desc = "marks";
          };
          "<leader>fp" = {
            action = "builtin";
            options.desc = "pickers";
          };
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
      noice = {
        enable = true;
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
      notify.enable = true;

      bufferline.enable = true;
      lualine.enable = true;
      alpha = {
        enable = true;
        theme = "theta";
      };

      which-key = {
        enable = true;
        registrations = {
          "<leader>t" = "toggle terminal";
          "<leader>f".name = "telescope";
          "<leader>l".name = "lsp";
        };
      };

      lspkind.enable = true;
      indent-blankline.enable = true;
      rainbow-delimiters.enable = true;
      todo-comments = {
        enable = true;
        keymaps = {
          todoTelescope = {
            key = "<leader>ft";
            options = {
              silent = true;
              desc = "todo";
            };
          };
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

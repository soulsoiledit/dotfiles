return {
	-- set colorscheme to catppuccin
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},

	{
		"williamboman/mason.nvim",
		opts = {
			PATH = "append",
		},
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["python"] = {
					"ruff_lint",
					"ruff_format",
				},

				["nix"] = {
					"nixfmt",
				},

				["zig"] = {
					"zigfmt",
				},
			},
		},
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
	},

	-- {
	-- 	"jbyuki/nabla.nvim",
	-- 	enable = false,
	-- 	config = function()
	-- 		require("nabla").enable_virt({ autogen = true })
	-- 	end,
	-- },

	-- add toggleterm and overrite keybind
	{
		"akinsho/toggleterm.nvim",
		config = true,
		keys = {
			{ "<leader>ft", "<cmd>ToggleTerm<CR>", desc = "Terminal (root dir)" },
		},
	},

	-- fzf-native
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},

	-- fix clangd errors
	{
		"neovim/nvim-lspconfig",
		opts = {
			setup = {
				clangd = function(_, opts)
					opts.capabilities.offsetEncoding = { "utf-16" }
				end,
			},
		},
	},

	-- supertab
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						-- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- this way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			})
		end,
	},
}

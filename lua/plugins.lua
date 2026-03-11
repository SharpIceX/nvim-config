-- 初始化 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
		"https://github.com/folke/lazy.nvim.git", lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- 配置 lazy.nvim
require("lazy").setup({
	spec = {
		-- 图标美化
		{
			'DaikyXendo/nvim-material-icon',
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			config = function()
				require('nvim-web-devicons').setup({
					default = true,
					color_icons = true,
				})
			end,
		},

		-- Catppuccin 主题
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			config = function()
				require("catppuccin").setup({
					flavour = "frappe",
					term_colors = true,
					integrations = {
						mason = true,
						snacks = true,
						trouble = true,
						blink_cmp = true,
						treesitter = true,
						native_lsp = {
							enabled = true,
							virtual_text = { hints = { "italic" }, errors = { "italic" } },
						},
					},
				})
				vim.cmd.colorscheme("catppuccin")
			end,
		},

		-- Mason 管理器
		{
			"williamboman/mason.nvim",
			build = ":MasonUpdate",
			config = function()
				require("mason").setup({ ui = { border = "rounded" } })
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("mason-lspconfig").setup({
					automatic_installation = true,
					ensure_installed = { "lua_ls", "pyright", "ts_ls" },
				})
			end,
		},

		-- NeoVim LSP 配置
		{
			"neovim/nvim-lspconfig",
			dependencies = { "saghen/blink.cmp" },
			event = { "BufReadPost", "BufNewFile" },
			config = function()
				local capabilities = require('blink.cmp').get_lsp_capabilities()

				-- UI
				local border = "rounded"
				vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
				vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp,
					{ border = border })

				-- 语言服务器
				local servers = { "pyright", "ts_ls", "lua_ls" }

				for _, lsp in ipairs(servers) do
					vim.lsp.config(lsp, {
						capabilities = capabilities,
						settings = lsp == "lua_ls" and {
							Lua = {
								diagnostics = { globals = { "vim" } },
								workspace = { checkThirdParty = false },
							},
						} or {},
					})

					vim.lsp.enable(lsp)
				end

				-- 4. 诊断信息美化
				vim.diagnostic.config({
					severity_sort = true,
					virtual_text = { prefix = "●" },
					float = { border = "rounded" },
				})
			end,
		},

		-- Trouble 诊断列表
		{
			"folke/trouble.nvim",
			opts = { mode = "workspace_diagnostics" },
			keys = {
				{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Toggle Trouble" },
				{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
			},
		},

		-- Blink.cmp 补全引擎
		{
			'saghen/blink.cmp',
			dependencies = { 'rafamadriz/friendly-snippets' },
			version = '*',
			opts = {
				keymap = { preset = 'super-tab' },
				appearance = { nerd_font_variant = 'mono' },
				sources = {
					default = { 'lsp', 'path', 'snippets', 'buffer' },
				},
				completion = {
					menu = { border = "rounded" },
					documentation = { auto_show = true, window = { border = "rounded" } },
				},
			},
		},

		-- 首页、通知美化
		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			opts = {
				indent = { enabled = true },
				scroll = { enabled = true },
				notifier = { enabled = true },
				dashboard = { enabled = true },
			},
		},

		-- Treesitter 语法高亮
		{
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
			build = ":TSUpdate",
			config = function()
				local ts = require('nvim-treesitter')

				ts.setup({
					install_dir = vim.fn.stdpath('data') .. '/site'
				})

				local ensure_installed = {
					"lua", "vim", "vimdoc", "query", "bash",
					"c", "cpp", "cmake", "make", "python",
					"javascript", "typescript", "yaml", "toml",
					"markdown", "markdown_inline"
				}

				-- 安装未安装的语言
				local to_install = {}
				for _, lang in ipairs(ensure_installed) do
					local ok = pcall(vim.treesitter.language.add, lang)
					if not ok then
						table.insert(to_install, lang)
					end
				end

				if #to_install > 0 then
					ts.install(to_install)
				end

				-- 自动开启高亮
				vim.api.nvim_create_autocmd('FileType', {
					callback = function()
						pcall(vim.treesitter.start)
					end,
				})

				-- 自动开启缩进
				vim.api.nvim_create_autocmd('FileType', {
					callback = function()
						local ok, ts_indent = pcall(require, 'nvim-treesitter.configs')
						if ok then
							vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						end
					end,
				})
			end,
		},
	},

	install = {
		colorscheme = {
			"catppuccin",
		}
	},
	checker = {
		enabled = false,
	},
})

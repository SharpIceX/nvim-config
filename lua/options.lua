-- # 内置选项
vim.opt.number = true
vim.opt.helplang = 'zh,en'
vim.opt.clipboard = 'unnamedplus'
vim.opt.guifont = 'JetBrainsMonoNL Nerd Font Mono:h12'

-- # 内置 api 配置
vim.api.nvim_create_autocmd('PackChanged', {
	callback = function (ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind

		if kind ~= 'install' and kind ~= 'update' then
			return
		end

		if name == 'nvim-treesitter' then
			-- nvim treesitter
			if not ev.data.active then
				vim.cmd.packadd(name)
			end
			vim.cmd('TSUpdate')
		elseif name == 'jieba.vim' then
			-- jieba.vim
			if not ev.data.active then
				vim.cmd.packadd(name)
			end
			vim.cmd('call jieba_vim#install()')
		end
	end,
})

-- # catppuccin 主题
require('catppuccin').setup({
	flavour = 'frappe',
	term_colors = true,
})
vim.cmd.colorscheme('catppuccin-frappe')

-- # 图标包
require('real-icons').setup()

-- # nvim-treesitter
require('nvim-treesitter').setup()
require('nvim-treesitter').install({
	'c',
	'po',
	'sql',
	'tsx',
	'ini',
	'csv',
	'zsh',
	'gpg',
	'lua',
	'vue',
	'vim',
	'cpp',
	'css',
	'xml',
	'pem',
	'html',
	'bash',
	'json',
	'rust',
	'toml',
	'http',
	'yaml',
	'udev',
	'hjson',
	'json5',
	'typst',
	'latex',
	'caddy',
	'regex',
	'query',
	'robot',
	'printf',
	'vimdoc',
	'python',
	'c_sharp',
	'jsonnet',
	'desktop',
	'kconfig',
	'markdown',
	'gitignore',
	'gitcommit',
	'git_rebase',
	'git_config',
	'robots_txt',
	'ssh_config',
	'javascript',
	'properties',
	'editorconfig',
	'gitattributes',
	'markdown_inline',
})
vim.api.nvim_create_autocmd('FileType', {
	callback = function (args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

-- # nvim-lspconfig
vim.lsp.enable({
	'html',
	'cssls',
	'ts_ls',
	'taplo',
	'vue_ls',
	'texlab',
	'lua_ls',
	'clangd',
	'bashls',
	'jsonls',
	'yamlls',
	'pyright',
	'lemminx',
	'marksman',
	'tinymist',
	'rust_analyzer',
})
vim.filetype.add({
	extension = {
		xsl = 'xsl',
		mdx = 'markdown.mdx',
	},
	filename = {
		['.gitlab-ci.yml'] = 'yaml.gitlab',
		['docker-compose.yml'] = 'yaml.docker-compose',
		['docker-compose.yaml'] = 'yaml.docker-compose',
	},
})

-- # blink.cmp
local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
	keymap = {
		preset = 'super-tab',
	},
	completion = {
		documentation = {
			auto_show_delay_ms = 300,
		},
	},
})

-- # jieba.vim
vim.g.jieba_vim_keymap = 1

-- # cord.nvim
require('cord').setup({
	buttons = {
		{
			label = 'View Repository',
			url = function (opts)
				return opts.repo_url
			end,
		},
	},
	advanced = {
		discord = {
			reconnect = {
				enabled = true,
			},
		},
	},
})

-- # gitsigns.nvim
require('gitsigns').setup()

-- # ts-comments.nvim
require('ts-comments').setup()

-- # todo-comments.nvim
require('todo-comments').setup()

-- # neogen
require('neogen').setup({})

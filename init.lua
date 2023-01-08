vim.opt.number = true
local plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
plug 'nvim-tree/nvim-web-devicons'
plug 'romgrk/barbar.nvim'
plug 'ntk148v/vim-horizon'
plug 'nvim-lualine/lualine.nvim'
plug 'Avimitin/neovim-deus'
plug 'kyazdani42/nvim-web-devicons'
plug 'nvim-tree/nvim-tree.lua'
plug 'akinsho/bufferline.nvim'
plug 'neoclide/coc.nvim'
vim.g.coc_global_extensions = {'coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier', 'coc-stylelint'}
plug 'ianks/vim-tsx'
plug 'leafgarland/typescript-vim'
plug 'dikiaap/minimalist'

vim.call('plug#end')

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.tsx"},
  callback = function(args)
    vim.opt_local.filetype = "typescript.tsx"
  end
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.ts"},
  callback = function(args)
    vim.opt_local.filetype = "typescript.ts"
  end
})

vim.cmd([[
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
]])

vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

-- examples for your init.lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
-- vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
    custom = { ".git" },
  },
})

--[=====[
require('rose-pine').setup({
	--- @usage 'main' | 'moon'
	dark_variant = 'main',
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = false,
	disable_float_background = false,
	disable_italics = false,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = 'base',
		panel = 'surface',
		border = 'highlight_med',
		comment = 'muted',
		link = 'iris',
		punctuation = 'subtle',

		error = 'love',
		hint = 'iris',
		info = 'foam',
		warn = 'gold',

		headings = {
			h1 = 'iris',
			h2 = 'foam',
			h3 = 'rose',
			h4 = 'gold',
			h5 = 'pine',
			h6 = 'foam',
		}
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	highlight_groups = {
		ColorColumn = { bg = 'rose' }
	}
})

vim.cmd('colorscheme rose-pine')
--]=====]

require('nvim-tree').toggle(false, true)

vim.g.nvim_tree_side                  = 'left'
vim.g.nvim_tree_width                 = 25
vim.g.nvim_tree_quit_on_open          = 1
vim.g.nvim_tree_disable_window_picker = 0
 
vim.g.nvim_tree_indent_markers         = 1
vim.g.nvim_tree_git_hl                 = 0
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_root_folder_modifier   = ':~'
vim.g.nvim_tree_add_trailing           = 1
vim.g.nvim_tree_icon_padding           = ' '
 
vim.g.nvim_tree_width_allow_resize    = 0
vim.g.nvim_tree_auto_resize           = 0
vim.g.nvim_tree_group_empty           = 1
vim.g.nvim_tree_lsp_diagnostics       = 1
vim.g.nvim_tree_disable_window_picker = 0
vim.g.nvim_tree_window_picker_exclude = {
  ["filetype"] = { 'packer', 'qf' },
  ["buftype"] =  { 'terminal' },
}
vim.g.nvim_tree_special_files = {
  'packer.nvim', 'README.md', 'README', 'TODO'
}
 
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_gitignore = 0
vim.g.nvim_tree_ignore = {
  '.git',
  'node_modules',
  '*.hi',
  '*.o',
  '*.aux',
  '__pycache__',
  '.cache',
}
 
-- ICONS:
vim.g.nvim_tree_show_icons =  {
  ["git"]           = 1,
  ["folders"]       = 1,
  ["files"]         = 1,
  ["folder_arrows"] = 1,
}

vim.cmd([[
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
i]])

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'horizon',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require('lualine').setup()

vim.cmd[[colorscheme horizon]]

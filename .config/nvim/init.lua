-- Load packer.nvim
vim.cmd [[packadd packer.nvim]]
local packer = require('packer')

-- Install plugins
packer.startup(function()
    use 'wbthomason/packer.nvim'

    use 'rust-lang/rust.vim'
    use 'neoclide/coc.nvim'
    use {'iamcco/diagnostic-languageserver', {'do': 'bash install.sh'}}
    use 'folke/trouble.nvim'

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
end)

-- Key mappings
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':nohlsearch<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true })

-- Coc.nvim configuration
vim.g.coc_global_extensions = {
  'coc-json',
  'coc-rls',
  'coc-tsserver',
  'coc-css',
  'coc-html',
  'coc-yaml',
  'coc-highlight',
  'coc-lists',
  'coc-pairs',
  'coc-snippets',
  'coc-spell-checker',
  'coc-git',
  'coc-vimtex',
}

-- Rust.vim configuration
vim.g.rustfmt_autosave = 1
vim.g.rust_recommended_style = 0
vim.g.rustfmt_command = 'rustfmt'
vim.g.rustfmt_options = {
  ['merge_imports'] = true,
  ['format_strings'] = true,
}

-- Neovim treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

-- Coc.nvim Rust configuration
vim.g.coc_config = {
  ['rust-analyzer'] = {
    checkOnSave = {
      command = 'clippy',
    },
    all_features = true,
  },
}

-- Trouble.nvim configuration
require('trouble').setup {
  position = 'bottom',
  height = 10,
  mode = 'lsp_workspace_diagnostics',
}

-- Set colorscheme
vim.cmd [[colorscheme gruvbox]]
-- Set default options
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.clipboard = ''

-- Set options for specific filetypes
vim.api.nvim_exec([[
  augroup FileTypeMappings
    autocmd!
    autocmd FileType rust setlocal shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType rust setlocal expandtab
    autocmd FileType rust setlocal textwidth=80
    autocmd FileType rust setlocal colorcolumn=81
  augroup END
]], false)

-- Set up Packer.nvim
vim.cmd [[packadd packer.nvim]]
require('packer').init()

-- Auto-compile and install plugins using Packer.nvim
vim.cmd [[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]]

-- Set up telescope.nvim
require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = '🔭 ',
    selection_caret = '❯ ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'flex',
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_ignore_patterns = {},
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = {
      '─',
      '│',
      '─',
      '│',
      '╭',
      '╮',
      '╯',
      '╰',
    },
    color_devicons = true,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    media_files = {
      filetypes = {'png', 'jpg', 'jpeg', 'mp4', 'webm', 'pdf'},
      find_cmd = 'rg',
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
}
require('telescope').load_extension('fzy_native')

-- Set up nvim-lspconfig
local lspconfig = require('lspconfig')
local on_attach = function(client)
  require('completion').on_attach()
end
lspconfig.rls.setup {
  on_attach = on_attach,
}

-- Set up completion.nvim
require('completion').setup {
  sorting = 'alphabet',
  matching_strategy_list = {'exact', 'substring', 'fuzzy'},
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'path'},
    {name = 'calc'},
    {name = 'emoji'},
    {name = 'spell'},
  },
  preselect = 'enable',
  auto_change_source = 'enable',
  auto_delete_preview = 'enable',
}

-- Set up treesitter-textobjects
require('nvim-treesitter.configs').setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aC'] = '@class.outer',
        ['iC'] = '@class.inner',
      },
    },
  },
}

-- Set up vim-surround
require('surround').setup {}

-- Set up vim-repeat
require('repeat').setup {}

-- Set up vim-sneak
vim.api.nvim_set_keymap('n', 's', '<Plug>Sneak_s', {})
vim.api.nvim_set_keymap('n', 'S', '<Plug>Sneak_S', {})
vim.api.nvim_set_keymap('n', 'f', '<Plug>Sneak_f', {})
vim.api.nvim_set_keymap('n', 'F', '<Plug>Sneak_F', {})

-- Set up vim-easymotion
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader><leader>', '<Plug>(easymotion-overwin-f2)', {})
vim.api.nvim_set_keymap('n', '<leader>j', '<Plug>(easymotion-lineforward)', {})
vim.api.nvim_set_keymap('n', '<leader>k', '<Plug>(easymotion-linebackward)', {})
vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(easymotion-s)', {})
vim.api.nvim_set_keymap('x', '<leader>f', '<Plug>(easymotion-s)', {})

-- Set up vim-vsnip
vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snippets'

-- Set up vimtex
vim.g.tex_flavor = 'latex'
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_latexmk = {
  options = {
    '-pdf',
    '-shell-escape',
    '-verbose',
    '-file-line-error',
    '-synctex=1',
  },
}

-- Set up vim-markdown
vim.g.markdown_fenced_languages = {
  'python',
  'javascript',
  'typescript',
  'html',
  'css',
}

-- Set up vim-visual-multi
vim.g.VM_mouse_mappings = 0
vim.g.VM_maps = {
  ['Find Under'] = '<C-Enter>',
  ['Find Subword Under'] = '<C-Enter>',
}

-- Set up vim-commentary
vim.api.nvim_set_keymap('n', '<leader>c', '<Plug>Commentary', {})
vim.api.nvim_set_keymap('x', '<leader>c', '<Plug>Commentary', {})

-- Set up vim-obsession
vim.g.obsession_save_on_set = 1

-- Set up vim-startuptime
vim.g.startuptime_tries = 10

-- Set up fugitive.vim
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiff<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', { noremap = true })

-- Set up dispatch.vim
vim.api.nvim_set_keymap('n', '<leader>dd', ':Dispatch<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dr', ':DispatchRust<CR>', { noremap = true })

-- Set up vim-unimpaired
vim.api.nvim_set_keymap('n', '<leader>o', ':<C-u>only<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true })

-- Set up vim-rooter
vim.g.rooter_patterns = { '.git', '.svn', 'Cargo.toml' }

-- Set up vim-emoji
vim.g.emoji_conceal = 1
vim.g.emoji_filetype_blacklist = { 'help', 'startify', 'dashboard' }

-- Set up vim-hexokinase
vim.g.Hexokinase_highlighters = { 'backgroundfull' }
vim.g.Hexokinase_optInPatterns = { 'full_hex', 'triple_hex', 'rgb', 'rgba', 'hsl', 'hsla' }
vim.g.Hexokinase_virtualText = ''
vim.g.Hexokinase_highlight_hovered_sign = ''

-- Set up neovim terminal configuration
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>w]], { noremap = true })
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

-- Set up neovim autocommands
vim.cmd [[autocmd! BufWritePost plugins.lua source <afile> | PackerCompile]]
vim.cmd [[autocmd FileType rust setlocal shiftwidth=4 tabstop=4 softtabstop=4]]
vim.cmd [[autocmd FileType rust setlocal expandtab]]
vim.cmd [[autocmd FileType rust setlocal textwidth=80]]
vim.cmd [[autocmd FileType rust setlocal colorcolumn=81]]

-- Set up nvim-dap
require('dapui').setup()
require('dap').adapters.rust = {
  type = 'executable',
  attach = {
    pidProperty = 'pid',
    pidSelect = 'ask',
  },
  command = 'lldb-vscode',
  name = 'lldb',
}
require('dap').configurations.rust = {{
    type = 'rust',
    name = 'Debug',
    request = 'launch',
    program = '${file}',
    args = {},
}}
vim.api.nvim_set_keymap('n', '<leader>dt', [[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dc', [[<cmd>lua require'dap'.continue()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dn', [[<cmd>lua require'dap'.step_over()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>di', [[<cmd>lua require'dap'.step_into()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>do', [[<cmd>lua require'dap'.step_out()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>du', [[<cmd>lua require'dapui'.toggle()<CR>]], { noremap = true })

-- Set up neogit
require('neogit').setup()

-- Set up gitsigns.nvim
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '│', numhl = 'GitSignsAddNr' },
    change = { hl = 'GitGutterChange', text = '│', numhl = 'GitSignsChangeNr' },
    delete = { hl = 'GitGutterDelete', text = '_', numhl = 'GitSignsDeleteNr' },
    topdelete = { hl = 'GitGutterDelete', text = '‾', numhl = 'GitSignsDeleteNr' },
    changedelete = { hl = 'GitGutterChange', text = '~', numhl = 'GitSignsChangeNr' },
  },
}

-- Set up vim-colorschemes
vim.cmd [[colorscheme gruvbox]]

-- Set up lsp_signature.nvim
require('lsp_signature').setup {
  bind = true,
  handler_opts = {
    border = 'none',
  },
  hint_enable = false,
}

-- Set up todo-comments.nvim
require('todo-comments').setup {}

-- Set up vim-illuminate
vim.g.Illuminate_highlightUnderCursor = 0
vim.g.Illuminate_delay = 100

-- Set up hop.nvim
vim.api.nvim_set_keymap('n', '<leader>hw', [[<cmd>lua require'hop'.hint_words()<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>hl', [[<cmd>lua require'hop'.hint_lines()<CR>]], {})

-- Set up lualine.nvim
require('lualine').setup {
  options = {
    theme = 'gruvbox',
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
}

-- Set up nvim-tree.lua
require('nvim-tree').setup {
  view = {
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = true,
      list = {
        { key = '<CR>', cb = require('nvim-tree.config').nvim_tree_callback('edit') },
        { key = '<C-v>', cb = require('nvim-tree.config').nvim_tree_callback('vsplit') },
        { key = '<C-x>', cb = require('nvim-tree.config').nvim_tree_callback('split') },
        { key = '<C-t>', cb = require('nvim-tree.config').nvim_tree_callback('tabnew') },
        { key = '<', cb = require('nvim-tree.config').nvim_tree_callback('prev_sibling') },
        { key = '>', cb = require('nvim-tree.config').nvim_tree_callback('next_sibling') },
      },
    },
  },
}

-- Set up telescope.nvim
require('telescope').setup {
  defaults = {
    prompt_prefix = '> ',
    selection_caret = '> ',
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
        ['<C-q>'] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist,
        ['<C-s>'] = require('telescope.actions').select_horizontal,
        ['<C-v>'] = require('telescope.actions').select_vertical,
      },
      n = {
        ['<C-q>'] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist,
      },
    },
  },
}

-- Set up vim-which-key
require('which-key').setup {
  plugins = {
    spelling = { enabled = true },
  },
}

-- Set up truezen.nvim
vim.g.truezen_show_statusline = 1
vim.g.truezen_custom_bg = 1
vim.g.truezen_fullscreen_hide_title = 1

-- Set up auto-pairs
require('nvim-autopairs').setup()

-- Set up vim-test
vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'vert'
vim.g['test#python#pytest#executable'] = 'python3'
vim.g['test#python#pytest#options'] = '--color=yes'
vim.g['test#python#runner'] = 'pytest'
vim.g['test#python#pytest#file_pattern'] = 'test_*.py'

-- Set up trouble.nvim
require('trouble').setup {}

-- Set up vim-symbols-outline
vim.api.nvim_set_keymap('n', '<leader>so', ':SymbolsOutline<CR>', { noremap = true })

-- Set up nvim-compe
require('compe').setup {
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
    ultisnips = true,
  },
}
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<CR>', 'compe#confirm("<CR>")', { noremap = true, silent = true, expr = true })

-- Set up neovim treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = { 'ruby' },
  },
  indent = {
    enable = true,
    disable = { 'python' },
  },
}

-- Set up vim-which-key
require('which-key').setup {}

-- Set up vim-surround
require('surround').setup {}

-- Set up nvim-peekup
require('nvim-peekup').setup {}

-- Set up vim-commentary
vim.api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>c', ':Commentary<CR>', { noremap = true })

-- Set up nvim-autopairs
require('nvim-autopairs').setup()

-- Set up neovim lspconfig
require('lspconfig').rust_analyzer.setup {}

-- Set up treesitter-refactor
require('nvim-treesitter.configs').setup {
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'grr',
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = 'gnd',
        list_definitions = 'gnD',
        list_definitions_toc = 'gO',
        goto_next_usage = '<a-*>',
        goto_previous_usage = '<a-#>',
      },
    },
  },
}

-- Set up neovim todo-comments
require('todo-comments').setup {}

-- Set up nvim-lspinstall
require('lspinstall').setup()

-- Set up neovim lspkind
require('lspkind').init {}

-- Set up nvim-ts-autotag
require('nvim-ts-autotag').setup()

-- Set up telescope.nvim
require('telescope').setup {
  defaults = {
    prompt_prefix = '> ',
    selection_caret = '> ',
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
        ['<C-q>'] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist,
        ['<C-s>'] = require('telescope.actions').select_horizontal,
        ['<C-v>'] = require('telescope.actions').select_vertical,
      },
      n = {
        ['<C-q>'] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist,
      },
    },
  },
}

-- Set up vim-which-key
require('which-key').setup {}

-- Set up vim-surround
require('surround').setup {}

-- Set up nvim-peekup
require('nvim-peekup').setup {}

-- Set up vim-commentary
vim.api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>c', ':Commentary<CR>', { noremap = true })

-- Set up nvim-autopairs
require('nvim-autopairs').setup()

-- Set up neovim lspconfig
require('lspconfig').rust_analyzer.setup {}

-- Set up treesitter-refactor
require('nvim-treesitter.configs').setup {
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'grr',
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = 'gnd',
        list_definitions = 'gnD',
        list_definitions_toc = 'gO',
        goto_next_usage = '<a-*>',
        goto_previous_usage = '<a-#>',
      },
    },
  },
}

-- Set up neovim todo-comments
require('todo-comments').setup {}

-- Set up nvim-lspinstall
require('lspinstall').setup()

-- Set up neovim lspkind
require('lspkind').init {}

-- Set up nvim-ts-autotag
require('nvim-ts-autotag').setup()

-- Set up telescope.nvim
require('telescope').setup {
  defaults = {
    prompt_prefix = '> ',
    selection_caret = '> ',
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
        ['<C-q>'] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist,
        ['<C-s>'] = require('telescope.actions').select_horizontal,
        ['<C-v>'] = require('telescope.actions').select_vertical,
      },
      n = {
        ['<C-q>'] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist,
      },
    },
  },
}

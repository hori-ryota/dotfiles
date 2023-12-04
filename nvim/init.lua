--{{{ config helpers
local ko = {
  nowait = true,
}
local ko_s = {
  nowait = true,
  silent = true,
}
local ko_b = {
  nowait = true,
  buffer = true,
}
local ko_sb = {
  nowait = true,
  silent = true,
  buffer = true,
}
local keymap = vim.keymap.set
--}}}

--{{{ Options
-- see `:options`
--{{{ 1 important
--}}}
--{{{ 2 moving around, searching and patterns
vim.opt.wrapscan = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
--}}}
--{{{ 3 tags
--}}}
--{{{ 4 displaying text
vim.opt.scrolloff = 5
vim.opt.lazyredraw = true
vim.opt.list = false
vim.opt.number = true
--}}}
--{{{ 5 syntax, highlighting and spelling
vim.opt.hlsearch = true
vim.cmd.nohlsearch()
vim.opt.termguicolors = true
vim.opt.spell = true
vim.opt.spellcapcheck = ''
vim.opt.spelloptions = { 'camel', 'noplainbuffer' }
vim.opt.spelllang:append('cjk')
local spellfile_dir = vim.fn.stdpath('config') .. '/spell'
if not (vim.fn.isdirectory(spellfile_dir)) then
  vim.fn.mkdir(spellfile_dir)
end
vim.opt.spellfile = spellfile_dir .. '/en.utf-8.add'
--}}}
--{{{ 6 multiple windows
vim.opt.laststatus = 2
vim.opt.hidden = false
--}}}
--{{{ 7 multiple tab pages
--}}}
--{{{ 8 terminal
vim.opt.sh = 'zsh'
keymap('t', '<ESC>', '<C-\\><C-n>', ko_s)
--}}}
--{{{ 9 using the mouse
--}}}
--{{{ 10 messages and info
--}}}
--{{{ 11 selecting text
--}}}
--{{{ 12 editing text
vim.opt.undofile = true
vim.opt.completeopt = 'menuone'
vim.opt.infercase = true
--}}}
--{{{ 13 tabs and indenting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.smarttab = false
vim.opt.expandtab = true
vim.opt.autoindent = true
--}}}
--{{{ 14 folding
vim.opt.foldmethod = 'marker'
--}}}
--{{{ 15 diff mode
vim.opt.diffopt:append('vertical')
vim.opt.diffopt:append('algorithm:histogram')
--}}}
--{{{ 16 mapping
vim.opt.ttimeoutlen = 10
--}}}
--{{{ 17 reading and writing files
vim.opt.fileformats = 'unix,mac,dos'
--}}}
--{{{ 18 the swap file
--}}}
--{{{ 19 command line editing
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildoptions = 'pum'
keymap('c', '<C-n>', '<Down>', ko)
keymap('c', '<C-p>', '<Up>', ko)
--}}}
--{{{ 20 executing external commands
--}}}
--{{{ 21 running make and jumping to errors
-- modify grep command to ripgrep
if vim.fn.executable('rg') then
  vim.opt.grepprg = 'rg --vimgrep'
  vim.opt.grepformat = '%f:%l:%c:%m'
end
--}}}
--{{{ 22 language specific
--}}}
--{{{ 23 multi-byte characters
vim.opt.fileencodings = 'utf-8,sjis'
--}}}
--{{{ 24 various
vim.opt.sessionoptions:append('winpos')
vim.opt.sessionoptions:append('winpos')
vim.opt.exrc = true
--}}}
--}}}

--{{{ base keymap
keymap('n', 's', '<Nop>')
vim.g.mapleader = 's'
vim.g.maplocalleader = 's'

-- turn off highlight
-- close preview window
keymap('n', '<ESC>', function()
  vim.cmd.nohlsearch()
  vim.cmd.pclose()
end, ko_s)

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    if vim.fn.getwininfo((vim.fn.win_getid()))[1].loclist then
      vim.cmd.wincmd('J')
    end
  end,
})
--}}}

--{{{ FileTypeDetect
vim.api.nvim_create_augroup('MyFileTypeDetect', {})
local function file_type_detect(pattern, type)
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = 'MyFileTypeDetect',
    pattern = pattern,
    command = 'setfiletype ' .. type,
  })
end

file_type_detect('*.{txt,text}', 'markdown')
file_type_detect('*.marp.md', 'markdown.marp')
file_type_detect({ 'envrc', 'envrc.*' }, 'zsh')
file_type_detect({ 'zlogin', 'zlogout', 'zpreztorc', 'zprofile', 'zshenv', 'zshrc' }, 'zsh')
file_type_detect('*.go.y', 'goyacc')
file_type_detect('*.uml', 'plantuml')
file_type_detect('*.mmd', 'mermaid')
file_type_detect('*.vim.local', 'vim')
file_type_detect('*.lua.local', 'lua')
file_type_detect('*Dockerfile*', 'dockerfile')
file_type_detect({ 'tsconfig.json', 'tsconfig.*.json', 'eslintrc', 'eslintrc.json', 'tasks.json', 'extensions.json' },
  'jsonc')
file_type_detect('editorconfig', 'editorconfig')
file_type_detect({ 'gitconfig', 'gitconfig.*', '.gitconfig.*' }, 'gitconfig')
file_type_detect({ 'gitignore', 'gitignore.*', '.gitignore.*' }, 'gitignore')
file_type_detect('*.hcl', 'hcl')
file_type_detect({ '.terraformrc', 'terraform.rc' }, 'hcl')
file_type_detect({ '*.tf', '*.tfvars' }, 'terraform')
file_type_detect({ '*.tfstate', '*.tfstate.backup' }, 'hcl')
--}}}

--{{{ install lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--}}}

require('lazy').setup({
  --{{{ ecosystems
  'vim-denops/denops.vim',
  'nvim-lua/plenary.nvim',
  'MunifTanjim/nui.nvim',
  {
    'stevearc/dressing.nvim',
    lazy = false,
    init = function()
      require('dressing').setup({
        select = {
          telescope = {
            layout_config = {
              bottom_pane = {
                height = '0.95',
              }
            },
          },
        },
      })
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    opts = {
      override = {
        txt = {
          icon = '',
          name = 'Txt',
          cterm_color = '113',
        },
        ['docker-compose.yml'] = {
          icon = '',
          cterm_color = '68',
          name = 'Dockerfile',
        },
        ['docker-compose.yaml'] = {
          icon = '',
          cterm_color = '68',
          name = 'Dockerfile',
        },
        ['.dockerignore'] = {
          icon = '',
          cterm_color = '68',
          name = 'Dockerfile',
        },
      },
    },
  },
  --}}}
  --{{{ LSP
  {
    'neovim/nvim-lspconfig', --{{{
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'j-hui/fidget.nvim',
    },
    lazy = false,
    config = function()
      vim.api.nvim_create_augroup('MyLspConfig', {})
      vim.diagnostic.config({
        --{{{
        virtual_text = {
          source = true,
          prefix = '',
        },
      }); --}}}

      keymap('n', '<Leader>L', '<Cmd>LspRestart<CR>', ko)

      --{{{ [\[gopls\] delay diagnostics or not run them in insert mode · Issue \#127 · neovim/nvim\-lspconfig](https://github.com/neovim/nvim-lspconfig/issues/127)
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- delay update diagnostics
        update_in_insert = false,
      });                           --}}}

      local function bind_key_map() --{{{
        local function telescope(f)
          return function()
            require('telescope.builtin')[f]()
          end
        end
        keymap('n', '<Leader>a', vim.lsp.buf.code_action, ko_sb)
        keymap('n', '<Leader><Leader>l', vim.lsp.codelens.run, ko_sb)
        keymap('n', '<Leader><Leader>L', function() vim.diagnostic.open_float({ focusable = false }) end, ko_sb)
        keymap('n', '[f', vim.diagnostic.goto_prev, ko_sb)
        keymap('n', ']f', vim.diagnostic.goto_next, ko_sb)
        keymap('n', '<Space>f', telescope('diagnostics'), ko_sb)
        keymap('n', 'K', vim.lsp.buf.hover, ko_sb)
        keymap('n', '<Space><Tab>', vim.lsp.buf.signature_help, ko_sb)
        keymap('n', '<C-]>', telescope('lsp_definitions'), ko_sb)
        keymap('n', '<Leader>i', telescope('lsp_implementations'), ko_sb)
        keymap('n', '<Leader>c', telescope('lsp_incoming_calls'), ko_sb)
        keymap('n', '<Leader>R', vim.lsp.buf.rename, ko_sb)
        keymap('n', '<Leader>gr', telescope('lsp_references'), ko_sb)
        keymap('n', '<Leader>a', vim.lsp.buf.code_action, ko_sb)
        keymap('v', '<Leader>a', vim.lsp.buf.code_action, ko_sb)
        keymap('n', 'gq', vim.lsp.buf.format, ko_sb)
        keymap('v', 'gq', vim.lsp.buf.format, ko_sb)
        keymap('n', '<Leader>ws', vim.lsp.buf.workspace_symbol, ko_sb)
      end --}}}

      vim.api.nvim_create_autocmd('LspAttach', {
        group = 'MyLspConfig',
        callback = function()
          bind_key_map()
          vim.cmd('hi! link DiagnosticError      ALEVirtualTextError')
          vim.cmd('hi! link DiagnosticWarn       ALEVirtualTextWarning')
          vim.cmd('hi! link DiagnosticInfo       Identifier')
          vim.cmd('hi! link DiagnosticHint       ALEVirtualTextWarning')
          vim.cmd('hi! link LspReferenceText     Normal')
          vim.cmd('hi! link LspReferenceRead     Identifier')
          vim.cmd('hi! link LspReferenceWrite    MoreMsg')
          vim.cmd('hi! link LspCodeLens          Comment')
          vim.cmd('hi! link LspCodeLensSeparator Comment')
        end,
      })

      local lspconfig = require('lspconfig')

      local function disable_formatter(client)
        client.server_capabilities.documentFormattingProvider = false;
        client.server_capabilities.documentRangeFormattingProvider = false;
      end

      local function fmt_on_save()
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = 'MyLspConfig',
          buffer = 0,
          callback = function() vim.lsp.buf.format() end,
        })
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      --{{{ filetype settings
      --{{{ for snippets
      -- table.insert(coc_global_extensions, 'coc-snippets')
      -- vim.fn['coc#config']('snippets', {
      --   userSnippetsDirectory = vim.fn.stdpath('config') .. '/snippets',
      -- })
      --}}}

      --{{{ for configuration files
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        init_options = {
          -- use prettier
          provideFormatter = false,
        },
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
            },
          },
        },
      })
      --}}}

      --{{{ for Vim
      lspconfig.vimls.setup({
        capabilities = capabilities,
      })
      --}}}

      --{{{ for lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })
      --}}}

      --{{{ for Markdown
      lspconfig.marksman.setup({
        capabilities = capabilities,
      })
      --}}}

      --{{{ for Python
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })
      --}}}

      --{{{ for Go
      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            ---- Build ----
            directoryFilters = { --{{{
              -- common
              '-**/.git',
              '-**/vendor',
              '-**/.symlinks',
              -- for Node.JS
              '-**/.next',
              '-**/.swc',
              '-**/node_modules',
              '-**/storybook-static',
              -- for Python
              '-**/.mypy_cache',
              '-**/__pycache__',
              '-**/.pytest_cache',
              '-**/.venv',
              '-**/venv',
              '-**/.neptune',
              -- for Terraform
              '-**/.terraform',
              -- for Dart and Flutter
              '-**/.dart_tool',
              -- for iOS
              '-**/Pods',
              '-**/.fvm',
              -- for MyProjects
              '-**/.cache',
              '-**/data',
              '-**/results',
              '-**/results_plots',
              '-**/output',
              '-**/.docker-compose-data',
              '-**/coverage',
            }, --}}}
            templateExtensions = {
              '.go.tmpl',
              '.go.tpl',
              '.gotmpl',
              '.gotpl',
            },
            ---- Formatting ----
            ['local'] = os.getenv('GO_IMPORTS_LOCAL'),
            ---- UI ----
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              test = false,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            ---- UI Completion ----
            usePlaceholders = true,
            ---- UI Diagnostic ----
            analyses = {
              nilness = true,
              unusedwrite = true,
            },
            ---- UI Documentation ----
            ---- UI Inlayhint ----
            ---- UI Navigation ----
          },
        },
        filetypes = {
          'go',
          'gomod',
          'gowork',
        },
        on_attach = function()
          fmt_on_save()
        end,
      })
      --}}}

      --{{{ for Rust
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = function()
          fmt_on_save()
        end,
      })
      --}}}

      --{{{ for Node.js and frontend development
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("package.json"),
        single_file_support = false,
        -- use prettier as formatter
        on_attach = disable_formatter
      })
      lspconfig.biome.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("biome.json"),
        single_file_support = false,
        cmd = { 'nlx', '@biomejs/biome', 'lsp-proxy' },
        on_attach = function()
          keymap('n', 'gQ', "<Cmd>execute '!nlx @biomejs/biome check --apply-unsafe ' . shellescape(expand('%:p'))<CR>",
            ko_b)
          fmt_on_save()
        end,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        -- use prettier as formatter
        init_options = { provideFormatter = false },
      })
      -- lspconfig.cssls.setup({
      --   capabilities = capabilities,
      --   -- use prettier as formatter
      --   init_options = { provideFormatter = false },
      -- })
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function()
          keymap('n', 'gQ', '<Cmd>EslintFixAll<CR><Cmd>lua vim.lsp.buf.format()<CR>', ko_b)
        end,
      })
      -- lspconfig.stylelint_lsp.setup({
      --   capabilities = capabilities,
      -- })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })
      lspconfig.emmet_language_server.setup({
        capabilities = capabilities,
      })
      lspconfig.prismals.setup({
        capabilities = capabilities,
      })
      --}}}

      --{{{ for Astro
      lspconfig.astro.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("astro.config.*"),
        on_attach = function()
          fmt_on_save()
        end,
      })
      --}}}

      --{{{ for Deno
      lspconfig.denols.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        on_attach = function()
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = 'MyLspConfig',
            buffer = 0,
            callback = function() vim.lsp.buf.format() end,
          })

          vim.opt_local.makeprg = 'deno run --allow-read --allow-net %'
        end,
      })
      --}}}

      --{{{ for Sell Scripts
      lspconfig.bashls.setup({
        capabilities = capabilities,
      })
      --}}}

      --{{{ for Terraform
      lspconfig.terraformls.setup({
        capabilities = capabilities,
        on_attach = function()
          fmt_on_save()
        end,
      })
      --}}}

      --{{{ for Docker
      lspconfig.dockerls.setup({
        capabilities = capabilities,
      })
      lspconfig.docker_compose_language_service.setup({
        capabilities = capabilities,
      })
      --}}}
      --}}}
    end,
  }, --}}}
  {
    'nvimtools/none-ls.nvim',
    lazy = false,
    config = function()
      require('null-ls').setup({
        diagnostics_format = '[#{c}] #{m} (#{s})',
        update_in_insert = false,
        sources = {
          -- make
          require('null-ls').builtins.diagnostics.checkmake,
          -- Dockerfile
          require('null-ls').builtins.diagnostics.hadolint,
          -- sh
          require('null-ls').builtins.formatting.shfmt,
          -- prettier
          require('null-ls').builtins.formatting.prettierd.with({
            -- use biome instead of prettier
            condition = function(utils)
              return utils.root_has_file({ ".prettierrc", ".prettierrc.js", ".prettierrc.cjs", ".prettierrc.json" })
            end,
          }),
          -- biome
          require('null-ls').builtins.formatting.biome.with({
            command = 'nlx @biomejs/biome',
            condition = function(utils)
              return utils.root_has_file({ "biome.json" })
            end,
          }),
          -- Go
          require('null-ls').builtins.code_actions.gomodifytags,
          require('null-ls').builtins.code_actions.impl,
          require('null-ls').builtins.diagnostics.golangci_lint,
          require('null-ls').builtins.formatting.goimports,
          -- Python
          require('null-ls').builtins.diagnostics.flake8,
          require('null-ls').builtins.diagnostics.mypy,
          require('null-ls').builtins.formatting.isort,
          -- GitHub Action
          require('null-ls').builtins.diagnostics.actionlint.with({
            runtime_condition = require('null-ls.helpers').cache.by_bufnr(function(params)
              return params.bufname:find(vim.pesc(".github/workflows")) ~= nil
            end)
          }),

          -- { "go", "javascript", "lua", "python", "typescript" }
          require('null-ls').builtins.code_actions.refactoring,
        },
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  },
  --}}}
  --{{{ Completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'petertriho/cmp-git',
    },
    event = {
      'InsertEnter',
      'CmdlineEnter',
    },
    config = function()
      local cmp = require('cmp')
      local types = require('cmp.types')
      local mapping = cmp.mapping

      local select_next_item_i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Insert })
        else
          fallback()
        end
      end
      local select_next_item_c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end
      local select_prev_item_i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert })
        else
          fallback()
        end
      end
      local select_prev_item_c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end

      cmp.setup({
        mapping = {
          --{{{
          ['<Tab>'] = {
            i = select_next_item_i,
            c = select_next_item_c,
          },
          ['<S-Tab>'] = {
            i = select_prev_item_i,
            c = select_prev_item_c,
          },
          ['<C-n>'] = {
            i = select_next_item_i,
          },
          ['<C-p>'] = {
            i = select_prev_item_i,
          },
          ['<CR>'] = {
            i = cmp.mapping.confirm({ select = false }),
            c = cmp.mapping.confirm({ select = false }),
          },
          ['<C-e>'] = {
            i = mapping.abort(),
            c = mapping.abort(),
          },
          ['<C-b>'] = {
            i = cmp.mapping.scroll_docs(-4),
            c = cmp.mapping.scroll_docs(-4),
          },
          ['<C-f>'] = {
            i = cmp.mapping.scroll_docs(4),
            c = cmp.mapping.scroll_docs(4),
          }
        }, --}}}
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = cmp.config.sources({
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
          { name = 'buffer' },
          { name = 'git' },
        }),
      })
      cmp.setup.cmdline({ '/', '?' }, {
        sources = {
          { name = 'buffer' },
        }
      })
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' },
          { name = 'cmdline_history' },
          { name = 'buffer' },
        })
      })
    end,
  },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'dmitmel/cmp-cmdline-history',
  'petertriho/cmp-git',
  {
    'saadparwaiz1/cmp_luasnip',
    dependencies = {
      'L3MON4D3/LuaSnip',
    },
  },
  --}}}
  --{{{ Snippets
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    cmd = 'InsertEnter',
    build = "make install_jsregexp",
    config = function()
      require('luasnip.loaders.from_snipmate').lazy_load({ paths = "./snippets" })
      local luasnip = require('luasnip')
      keymap('i', '<C-l>', function() luasnip.expand_or_jump() end, ko_s)
    end,
  },
  --}}}
  --{{{ copilot
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = '<C-a>',
            prev = '<C-k>',
            next = '<C-j>',
            dissmiss = '<C-d>',
          },
        },
        panel = {
          enabled = true,
          keymap = {
            accept = '<CR>',
            jump_prev = '<C-k>',
            jump_next = '<C-j>',
            refresh = '<C-l>',
            open = '<C-q>',
          },
          layout = {
            position = 'right',
          },
        },
      })
      -- vim.api.nvim_command('highlight link CopilotSuggestion Comment')
    end,
  },
  --}}}
  --{{{ ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        openai_params = {
          model = "gpt-4",
        },
        edit_with_instructions = {
          diff = true,
          keymaps = {
            close = "<C-q>",
            accept = "<C-y>",
            toggle_diff = "<C-d>",
            toggle_settings = "<C-o>",
            cycle_windows = "<Tab>",
            use_output_as_input = "<C-]>",
          },
        },
        chat = {
          wellcome_mesasge = "ChatGPT",
          keymaps = {
            close = { "<C-q>" },
            yank_last = "<C-y><C-y>",
            yank_last_code = "<C-y>y",
            scroll_up = "<C-b>",
            scroll_down = "<C-f>",
            new_session = "<C-a>",
            cycle_windows = "<Tab>",
            cycle_modes = "<C-t>",
            next_message = "<C-j>",
            prev_message = "<C-k>",
            select_session = "<CR>",
            rename_session = "R",
            delete_session = "D",
            draft_message = "<C-h>",
            edit_message = "E",
            delete_message = "D",
            toggle_settings = "<C-o>",
            toggle_message_role = "<C-x>",
            toggle_system_role_open = "<C-e>",
            stop_generating = "<C-c>",
          },
        },
        popup_input = {
          submit = "<C-]>",
          submit_n = "<CR>",
          max_visible_lines = 20,
        },
      })
      keymap('n', '<Space>cc', '<Cmd>ChatGPT<CR>', ko)
      keymap('n', '<Space>ci', '<Cmd>ChatGPTEditWithInstructions<CR>', ko)
      keymap('x', '<Space>ci', ':ChatGPTEditWithInstructions<CR>', ko)
      keymap('n', '<Space>cr', ':ChatGPT Run ', ko)
    end,
  },
  --}}}
  --{{{ telescope
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope-file-browser.nvim',
      'AckslD/nvim-neoclip.lua',
    },
    cmd = 'Telescope',
    init = function() --{{{
      keymap('n', '<Space><Space>', '<Cmd>Telescope find_files<CR>', ko_s)
      keymap('n', '<Space>w', '<Cmd>Telescope file_browser<CR>', ko_s)
      keymap('n', '<Space>W', '<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>', ko_s)
      keymap('n', '<Space>b', '<Cmd>Telescope buffers<CR>', ko_s)
      keymap('n', '<Space>r', '<Cmd>Telescope live_grep<CR>', ko_s)
      keymap('n', '<Space>.', '<Cmd>Telescope resume<CR>', ko_s)

      keymap('n', '<Space>vs', '<Cmd>Telescope git_status<CR>', ko_s)
      keymap('n', '<Space>vl', function()
        require('telescope.builtin').git_commits({
          git_command = {
            "git",
            "log",
            "--pretty=%h %cd [%an] %s %d",
            "--date=iso-local",
            "--", ".",
          }
        })
      end, ko_s)
      keymap('n', '<Space>vL', function()
        require('telescope.builtin').git_bcommits({
          git_command = {
            "git",
            "log",
            "--pretty=%h %cd [%an] %s %d",
            "--date=iso-local",
          }
        })
      end, ko_s)

      keymap('n', '<Space>p', '<Cmd>Telescope neoclip<CR>', ko_s)
      keymap('n', '<Space>q', '<Cmd>Telescope macroscope<CR>', ko_s)
      keymap('n', '<Space>ip', '<C-u>Telescope neoclip ', ko_s)
      keymap('n', '<Space>iq', '<C-u>Telescope macroscope ', ko_s)

      -- memolist
      keymap('n', '<Space>ml', function()
        require('telescope.builtin').find_files({
          cwd = vim.g.memolist_path,
          find_command = { 'rg', '--files', '--sortr', 'path' },
        })
      end, ko_s)
      keymap('n', '<Space>mr', function()
        require('telescope.builtin').live_grep({ cwd = vim.g.memolist_path })
      end, ko_s)

      -- dotfiles
      keymap('n', '<Space>sl', function()
        require('telescope.builtin').find_files({ cwd = os.getenv('HOME') .. '/.dotfiles' })
      end, ko_s)
      keymap('n', '<Space>sr',
        function() require('telescope.builtin').live_grep({ cwd = os.getenv('HOME') .. '/.dotfiles' }) end, ko_s)
    end,                --}}}
    config = function() --{{{
      local actions = require("telescope.actions")
      local fb_actions = require('telescope').extensions.file_browser.actions
      require("telescope").setup({
        defaults = {
          mappings = {
            --{{{
            n = {
              ['<esc>']      = actions.close,
              ['<CR>']       = actions.select_default,
              s              = actions.select_horizontal,
              S              = actions.select_vertical,
              gs             = actions.select_tab,
              j              = actions.move_selection_next,
              k              = actions.move_selection_previous,
              H              = actions.move_to_top,
              M              = actions.move_to_middle,
              L              = actions.move_to_bottom,
              gg             = actions.move_to_top,
              G              = actions.move_to_bottom,
              x              = actions.toggle_selection + actions.move_selection_worse,
              X              = actions.toggle_all,
              ['<C-f>']      = actions.preview_scrolling_down,
              ['<C-b>']      = actions.preview_scrolling_up,
              ['?']          = actions.which_key,
              -- disable defaults
              ['<C-D>']      = false,
              ['<C-U>']      = false,
              ['<C-q>']      = false,
              ['<C-t>']      = false,
              ['<C-v>']      = false,
              ['<C-x>']      = false,
              ['<M-q>']      = false,
              ['<Tab>']      = false,
              ['<S-Tab>']    = false,
              ['<Up>']       = false,
              ['<Down>']     = false,
              ['<PageUp>']   = false,
              ['<PageDown>'] = false,
            },
            i = {
              ['<CR>']       = actions.select_default,
              ['<C-s>']      = actions.select_horizontal,
              ['<C-v>']      = actions.select_vertical,
              ['<C-j>']      = actions.move_selection_next,
              ['<C-k>']      = actions.move_selection_previous,
              ['<C-f>']      = actions.preview_scrolling_down,
              ['<C-b>']      = actions.preview_scrolling_up,
              -- disable defaults
              ['<C-c>']      = false,
              ['<C-d>']      = false,
              ['<C-l>']      = false,
              ['<C-p>']      = false,
              ['<C-q>']      = false,
              ['<C-t>']      = false,
              ['<C-u>']      = false,
              ['<M-q>']      = false,
              ['<Tab>']      = false,
              ['<S-Tab>']    = false,
              ['<Up>']       = false,
              ['<Down>']     = false,
              ['<PageUp>']   = false,
              ['<PageDown>'] = false,
            },
          } --}}}
        },
        extensions = {
          file_browser = {
            hidden = true,
            mappings = {
              --{{{
              n = {
                A = fb_actions.create,
                R = fb_actions.rename,
                M = fb_actions.move,
                C = fb_actions.copy,
                D = fb_actions.remove,
                o = fb_actions.open,
                ['<C-h>'] = fb_actions.goto_parent_dir,
                H = fb_actions.goto_cwd,
                X = fb_actions.toggle_all,
                -- disable defaults
                c = false,
                r = false,
                m = false,
                y = false,
                d = false,
                g = false,
                e = false,
                w = false,
                t = false,
                f = false,
                h = false,
                s = false,
              },
              i = {
                -- disable defaults
                ["<A-c>"]  = false,
                ["<S-CR>"] = false,
                ["<A-r>"]  = false,
                ["<A-m>"]  = false,
                ["<A-y>"]  = false,
                ["<A-d>"]  = false,
                ["<C-o>"]  = false,
                ["<C-g>"]  = false,
                ["<C-e>"]  = false,
                ["<C-w>"]  = false,
                ["<C-t>"]  = false,
                ["<C-f>"]  = false,
                ["<C-h>"]  = false,
                ["<C-s>"]  = false,
                ["<bs>"]   = false,
              },
            }, --}}}
          },
        },
      })
    end, --}}}
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    config = function()
      require('telescope').load_extension('file_browser')
    end,
  },
  {
    'lpoto/telescope-docker.nvim',
    init = function()
      keymap('n', '<Space>di', function() require('telescope').extensions.docker.images() end, ko)
      keymap('n', '<Space>dc', function() require('telescope').extensions.docker.containers() end, ko)
    end,
    config = function()
      require('telescope').load_extension('docker')
    end,
  },
  'kkharji/sqlite.lua',
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      'kkharji/sqlite.lua',
    },
    config = function()
      require('neoclip').setup({
        enable_persistent_history = true,
        enable_macro_history = true,
        keys = {
          telescope = {
            i = {
              select = '<c-\\>',
              paste = '<cr>',
              paste_behind = '<c-\\>',
              replay = '<c-q>',  -- replay a macro
              delete = '<c-\\>', -- delete an entry
              edit = '<c-\\>',   -- edit an entry
              custom = {},
            },
            n = {
              select = '<c-\\>',
              paste = '<cr>',
              paste_behind = '<c-\\>',
              replay = '<c-q>',  -- replay a macro
              delete = '<c-\\>', -- delete an entry
              edit = '<c-\\>',   -- edit an entry
              custom = {},
            },
          },
        },
      })
      require('telescope').load_extension('neoclip')
    end,
  },
  --}}}
  --{{{ filer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'stevearc/oil.nvim',
    },
    init = function()
      keymap('n', '<Space>e', function() require('nvim-tree.api').tree.toggle() end, ko_s)
      keymap('n', '<Space>E', function()
        require('nvim-tree.api').tree.toggle({
          find_file = true,
          focus = true,
        })
      end, ko_s)
    end,
    opts = {
      git = {
        ignore = false,
      },
      view = {
        width = 60,
      },
      renderer = {
        icons = {
          git_placement = 'signcolumn',
        },
      },
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function apply(keys, target, desc)
          vim.keymap.set('n', keys, target,
            { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true })
        end
        local function toggleTreeOrOpen()
          local lib = require('nvim-tree.lib')
          local view = require('nvim-tree.view')
          local action = 'edit'
          local node = lib.get_node_at_cursor()

          if node.link_to and not node.nodes then
            require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
            view.close() -- Close the tree if file was opened
          elseif node.nodes ~= nil then
            lib.expand_or_collapse(node)
          else
            require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
            view.close() -- Close the tree if file was opened
          end
        end

        apply('o', toggleTreeOrOpen, 'toggle tree or open')
        apply('<CR>', toggleTreeOrOpen, 'toggle tree or open')

        apply('<C-l>', api.tree.reload, 'reload')
        apply('K', api.node.show_info_popup, 'info')

        -- select
        apply('x', api.marks.toggle, 'toggle mark')
        apply('X', api.marks.clear, 'clear marks')

        -- action
        apply('a', api.fs.create, 'create')
        apply('d', api.fs.remove, 'remove')
        apply('m', api.fs.cut, 'cut')
        apply('c', api.fs.copy.node, 'copy')
        apply('p', api.fs.paste, 'paste')
        apply('<C-p>', api.fs.clear_clipboard, 'clear clipboard')
        apply('P', api.fs.print_clipboard, 'print clipboard')
        apply('r', api.fs.rename_node, 'rename')
        apply('S', api.node.open.vertical, 'edit vertical')
        apply('s', api.node.open.horizontal, 'edit horizontal')
        apply('gcd', api.tree.change_root_to_node, 'change root')
        apply('y', api.fs.copy.absolute_path, 'yank absolute_path')
        apply('<space>h', api.tree.change_root_to_parent, 'change root to parent')
        apply('<space>l', api.tree.change_root_to_node, 'change root to node')
        apply('E', function()
          local lib = require('nvim-tree.lib')
          local node = lib.get_node_at_cursor()
          local dir = node.type == 'directory' and node.absolute_path or node.parent.absolute_path
          require('oil').open(dir)
        end, 'open by oil.nvim')

        apply('?', api.tree.toggle_help, 'help')
        apply('gf', api.live_filter.start, 'live fitler start')
        apply('gF', api.live_filter.clear, 'live fitler clear')
      end
      ,
    },
  },
  {
    'stevearc/oil.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      require("oil").setup({
        default_file_exploler = false,
        use_default_keymaps = false,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<Space>v"] = "actions.select_vsplit",
          ["<Space>s"] = "actions.select_split",
          ["<Space>t"] = "actions.select_tab",
          ["<Space>p"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["<Space>h"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
  --}}}
  --{{{ Git
  {
    'f-person/git-blame.nvim',
    keys = {
      { '<Space>vBB', '<Cmd>GitBlameToggle<CR>' },
      { '<Space>vBh', '<Cmd>GitBlameCopySHA<CR><Cmd>GitBlameDisable<CR>' },
      { '<Space>vBy', '<Cmd>GitBlameCopyCommitURL<CR><Cmd>GitBlameDisable<CR>' },
      { '<Space>vO',  '<Cmd>GitBlameOpenFileURL<CR><Cmd>GitBlameDisable<CR>' },
    },
    init = function()
      vim.g.gitblame_date_format = '%Y-%m-%d %H:%m:%S'
    end
  },
  --}}}
  --{{{ GitHub
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Octo',
    init = function()
      keymap('n', '<Space>vil', '<Cmd>Octo issue list<CR>', ko)
      keymap('n', '<Space>vpl', '<Cmd>Octo pr list<CR>', ko)
    end,
    config = function()
      vim.treesitter.language.register('markdown', 'octo')
      require('octo').setup({
        default_remote = { 'upstream', 'origin', 'hori-ryota' },
        mappings = {
          issue = {
            close_issue = { lhs = "<Leader>DD", desc = "close PR" },
            reopen_issue = { lhs = "<Leader>OO", desc = "reopen PR" },
            list_issues = { lhs = "<Space>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-l>", desc = "reload PR" },
            open_in_browser = { lhs = "<Space>br", desc = "open PR in browser" },
            copy_url = { lhs = "<Leader>y", desc = "copy url to system clipboard" },
            add_assignee = { lhs = "<Leader>aA", desc = "add assignee" },
            remove_assignee = { lhs = "<Leader>aD", desc = "remove assignee" },
            create_label = { lhs = "<Leader>LC", desc = "create label" },
            add_label = { lhs = "<Leader>LA", desc = "add label" },
            remove_label = { lhs = "<Leader>LD", desc = "remove label" },
            goto_issue = { lhs = "<C-]>", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<Leader>cA", desc = "add comment" },
            delete_comment = { lhs = "<Leader>cD", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<Leader>et", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<Leader>eh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<Leader>ee", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<Leader>e+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<Leader>e-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<Leader>er", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<Leader>es", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<Leader>ec", desc = "add/remove 😕 reaction" },
          },
          pull_request = {
            checkout_pr = { lhs = "<Leader>X", desc = "checkout PR" },
            merge_pr = { lhs = "<Leader>MM", desc = "merge commit PR" },
            squash_and_merge_pr = { lhs = "<Leader>SS", desc = "squash and merge PR" },
            list_commits = { lhs = "<Space>l", desc = "list PR commits" },
            list_changed_files = { lhs = "<Space>f", desc = "list PR changed files" },
            show_pr_diff = { lhs = "<Space>d", desc = "show PR diff" },
            add_reviewer = { lhs = "<Leader>rA", desc = "add reviewer" },
            remove_reviewer = { lhs = "<Leader>rD", desc = "remove reviewer request" },
            close_issue = { lhs = "<Leader>DD", desc = "close PR" },
            reopen_issue = { lhs = "<Leader>OO", desc = "reopen PR" },
            list_issues = { lhs = "<Space>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-l>", desc = "reload PR" },
            open_in_browser = { lhs = "<Space>br", desc = "open PR in browser" },
            copy_url = { lhs = "<Leader>y", desc = "copy url to system clipboard" },
            goto_file = { lhs = "gf", desc = "go to file" },
            add_assignee = { lhs = "<Leader>aA", desc = "add assignee" },
            remove_assignee = { lhs = "<Leader>aD", desc = "remove assignee" },
            create_label = { lhs = "<Leader>LC", desc = "create label" },
            add_label = { lhs = "<Leader>LA", desc = "add label" },
            remove_label = { lhs = "<Leader>LD", desc = "remove label" },
            goto_issue = { lhs = "<C-]>", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<Leader>cA", desc = "add comment" },
            delete_comment = { lhs = "<Leader>cD", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<Leader>et", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<Leader>eh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<Leader>ee", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<Leader>e+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<Leader>e-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<Leader>er", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<Leader>es", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<Leader>ec", desc = "add/remove 😕 reaction" },
          },
          review_thread = {
            goto_issue = { lhs = "<C-]>", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<Leader>cA", desc = "add comment" },
            add_suggestion = { lhs = "<Leader>gA", desc = "add suggestion" },
            delete_comment = { lhs = "<Leader>cD", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            select_next_entry = { lhs = "]e", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[e", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            react_hooray = { lhs = "<Leader>et", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<Leader>eh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<Leader>ee", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<Leader>e+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<Leader>e-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<Leader>er", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<Leader>es", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<Leader>ec", desc = "add/remove 😕 reaction" },
          },
          submit_win = {
            approve_review = { lhs = "<Space>vp<C-a>", desc = "approve review" },
            comment_review = { lhs = "<Space>vp<C-c>", desc = "comment review" },
            request_changes = { lhs = "<Space>vp<C-r>", desc = "request changes review" },
            close_review_tab = { lhs = "<Space>vp<C-d>", desc = "close review tab" },
          },
          review_diff = {
            add_review_comment = { lhs = "<Leader>cA", desc = "add a new review comment" },
            add_review_suggestion = { lhs = "<Leader>gA", desc = "add a new review suggestion" },
            focus_files = { lhs = "<Space>F", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<Space>f", desc = "hide/show changed files panel" },
            next_thread = { lhs = "]t", desc = "move to next thread" },
            prev_thread = { lhs = "[t", desc = "move to previous thread" },
            select_next_entry = { lhs = "]e", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[e", desc = "move to next changed file" },
            close_review_tab = { lhs = "<Esc>", desc = "close review tab" },
            toggle_viewed = { lhs = "<Leader>V", desc = "toggle viewer viewed state" },
          },
          file_panel = {
            next_entry = { lhs = "j", desc = "move to next changed file" },
            prev_entry = { lhs = "k", desc = "move to previous changed file" },
            select_entry = { lhs = "o", desc = "show selected changed file diffs" },
            refresh_files = { lhs = "<C-l>", desc = "refresh changed files panel" },
            focus_files = { lhs = "<Space>F", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<Space>f", desc = "hide/show changed files panel" },
            select_next_entry = { lhs = "]e", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[e", desc = "move to next changed file" },
            close_review_tab = { lhs = "<Esc>", desc = "close review tab" },
            toggle_viewed = { lhs = "<Leader>V", desc = "toggle viewer viewed state" },
          },
        },
      })
      vim.api.nvim_create_augroup('MyOcto', {})
      vim.api.nvim_create_autocmd('FileType', {
        group = 'MyOcto',
        pattern = 'octo',
        callback = function()
          keymap('n', '<Space>s', '<Cmd>Octo pr checks<CR>', ko_b)
        end,
      })
    end,
  },
  --}}}
  --{{{ Async Execution
  {
    'stevearc/overseer.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
    },
    lazy = false,
    init = function()
      require('overseer').setup({
        task_list = {
          bindings = {
            ["?"] = "ShowHelp",
            ["g?"] = "ShowHelp",
            ["<CR>"] = "RunAction",
            ["E"] = "Edit",
            ["O"] = "Open",
            ["V"] = "OpenVsplit",
            ["S"] = "OpenSplit",
            ["F"] = "OpenFloat",
            ["Q"] = "OpenQuickFix",
            ["P"] = "TogglePreview",
            ["zo"] = "IncreaseDetail",
            ["zc"] = "DecreaseDetail",
            ["zO"] = "IncreaseAllDetail",
            ["zC"] = "DecreaseAllDetail",
            ["{"] = "DecreaseWidth",
            ["}"] = "IncreaseWidth",
            ["<C-k>"] = "PrevTask",
            ["<C-j>"] = "NextTask",
            ["<C-b>"] = "ScrollOutputUp",
            ["<C-f>"] = "ScrollOutputDown",
            ["<ESC>"] = "Close",
          },
          direction = "bottom",
          min_height = 20,
        },
      })
      keymap('n', '<Space>o', '<Cmd>OverseerToggle<CR>', ko)
      keymap('n', '<Leader>o', '<Cmd>OverseerRun<CR><Cmd>OverseerOpen<CR>', ko)

      local overseer = require('overseer')

      keymap('n', '<Leader>r', function()
        overseer.run_template({
          name = 'shell',
          params = {
            cmd = vim.fn.expand('%:p'),
          },
        })
        overseer.open()
      end, ko)

      for k, v in pairs({
        ["<Leader>npb"] = "nlx turbo run build",
        ["<Leader>npc"] = "nlx turbo run check",
        ["<Leader>npg"] = "nlx turbo run generate",
        ["<Leader>npq"] = "nlx turbo run autofix",
        ["<Leader>npd"] = "nlx turbo run dev --concurrency=100",
        ["<Leader>dpu"] = "docker compose up -d",
        ["<Leader>dpU"] = "docker compose up -d --build",
        ["<Leader>dpd"] = "docker compose down",
        ["<Leader>dpl"] = "docker compose logs -f",
      }) do
        keymap('n', k, function()
          overseer.run_template({
            name = 'shell',
            params = {
              cmd = v,
            },
          })
          overseer.open()
        end, ko)
      end
      for k, v in pairs({
        ["<Leader>ni"] = "ni",
        ["<Leader>nb"] = "nr build",
        ["<Leader>nc"] = "nr check",
        ["<Leader>ng"] = "nr generate",
        ["<Leader>nq"] = "nr autofix",
        ["<Leader>nd"] = "nr dev",
        ["<Leader>du"] = "docker compose up -d",
        ["<Leader>dU"] = "docker compose up -d --build",
        ["<Leader>dd"] = "docker compose down",
        ["<Leader>dl"] = "docker compose logs -f",
        ["<Leader>fP"] = "terraform plan",
        ["<Leader>fA"] = "terraform apply",
        ["<Leader>fI"] = "terraform init",
        ["<Leader>fU"] = "terraform init -upgrade",
      }) do
        keymap('n', k, function()
          overseer.run_template({
            name = 'shell',
            params = {
              cmd = v,
              cwd = vim.fn.expand('%:h'),
            },
          })
          overseer.open()
        end, ko)
      end
      keymap('n', '<Leader>na', function()
        overseer.run_template({
          name = 'shell',
          params = {
            cmd = 'ni ',
            cwd = vim.fn.expand('%:h'),
          },
          prompt = 'always',
        })
      end, ko)

      local function terraform_dir()
        local dir = os.getenv('TERRAFORM_DIR')
        if not (dir) then
          dir = '.'
        end
        return dir
      end
      for k, v in pairs({
        ["<Leader>fp"] = "terraform plan",
        ["<Leader>fa"] = "terraform apply",
        ["<Leader>fi"] = "terraform init",
        ["<Leader>fu"] = "terraform init -upgrade",
      }) do
        keymap('n', k, function()
          overseer.run_template({
            name = 'shell',
            params = {
              cmd = v,
              cwd = terraform_dir(),
            },
          })
          overseer.open()
        end, ko)
      end
    end
  },
  --}}}
  --{{{ Testing
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    init = function()
      keymap('n', '<Leader>t', function() require("neotest").run.run(vim.fn.expand('%')) end, ko)
      keymap('n', '<Leader>T', function() require("neotest").run.run() end, ko)
      keymap('n', '<Leader>gt', function() require("neotest").run.run(vim.fn.expand('%:h')) end, ko)
      keymap('n', ']T', function() require("neotest").jump.next({ status = "failed" }) end, ko)
      keymap('n', '[T', function() require("neotest").jump.prev({ status = "failed" }) end, ko)
      keymap('n', '<Space>to', function() require("neotest").output.open({ enter = true }) end, ko)
      keymap('n', '<Space>ts', function() require("neotest").summary.toggle() end, ko)
    end,
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace('neotest')
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
                diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)
      require('neotest').setup({
        -- your neotest config here
        adapters = {
          require('neotest-go')({
            experimental = {
              test_table = true,
            },
            args = {
              '-count=1',
            },
          }),
          require('neotest-python'),
          require('neotest-jest'),
          require('neotest-vitest'),
          require('neotest-playwright').adapter({
            options = {
              enable_dynamic_test_discovery = true,
            },
          }),
          require('neotest-dart'),
        },
        consumers = {
          playwright = require("neotest-playwright.consumers").consumers,
        },
        icons = {
          failed  = '',
          passed  = '',
          running = '',
          skipped = '',
          unknown = '',
        },
        summary = {
          mappings = {
            next_failed = ']T',
            prev_failed = '[T',
            expand = 'o',
            expand_all = 'O',
            jumpto = '<CR>',
            mark = 'x',
            clear_marked = 'X',
            run = 'r',
            run_marked = 'R',
            short = 'P',
          },
        },
      })
    end,
  },
  'nvim-neotest/neotest-go',
  'nvim-neotest/neotest-python',
  'haydenmeade/neotest-jest',
  'marilari88/neotest-vitest',
  'thenbe/neotest-playwright',
  'sidlatau/neotest-dart',
  -- NOTE: neotest-denoはまだWIPな模様（README.mdにWIPと記載、docに `*neotest.config*` がありhelptagsが本体との重複で失敗する）
  --}}}
  --{{{ Utilities
  {
    -- easily search for, substitute, and abbreviate multiple variants of a word

    'tpope/vim-abolish',
    lazy = false,
  },
  {
    -- replacement in quickfix
    'thinca/vim-qfreplace',
    cmd = 'Qfreplace',
  },
  {
    'itchyny/vim-qfedit',
    lazy = false,
  },
  {
    'direnv/direnv.vim',
    lazy = false,
  },
  {
    -- Aligning Text
    'junegunn/vim-easy-align',
    keys = {
      { '<Enter>', '<Plug>(EasyAlign)', mode = 'v' },
      { 'ga',      '<Plug>(EasyAlign)', mode = 'n' },
    },
  },
  {
    -- pairs of handy bracket mappings
    'tpope/vim-unimpaired',
    lazy = false,
  },
  {
    'andymass/vim-matchup',
    lazy = false,
  },
  {
    -- edit surround easy
    'machakann/vim-sandwich',
    init = function()
      vim.g.sandwich_no_default_key_mappings = 1
      vim.g.operator_sandwich_no_default_key_mappings = 1
    end,
    keys = { --{{{
      -- add
      {
        '<Leader>wa',
        '<Plug>(operator-sandwich-add)',
        mode = 'n'
      },
      {
        '<Leader>wa',
        '<Plug>(operator-sandwich-add)',
        mode = 'x'
      },
      {
        '<Leader>wa',
        '<Plug>(operator-sandwich-g@)',
        mode = 'o'
      },
      -- delete
      {
        '<Leader>wd',
        '<Plug>(operator-sandwich-delete)' ..
        '<Plug>(operator-sandwich-release-count)' ..
        '<Plug>(textobj-sandwich-query-a)',
        mode = 'n'
      },
      {
        '<Leader>wdb',
        '<Plug>(operator-sandwich-delete)' ..
        '<Plug>(operator-sandwich-release-count)' .. '<Plug>(textobj-sandwich-auto-a)',
        mode = 'n'
      },
      {
        '<Leader>wd',
        '<Plug>(operator-sandwich-delete)',
        mode = 'x'
      },
      -- replace
      {
        '<Leader>wrd',
        '<Plug>(operator-sandwich-replace)' ..
        '<Plug>(operator-sandwich-release-count)' ..
        '<Plug>(textobj-sandwich-query-a)',
        mode = 'n'
      },
      {
        '<Leader>wrdb',
        '<Plug>(operator-sandwich-replace)' ..
        '<Plug>(operator-sandwich-release-count)' .. '<Plug>(textobj-sandwich-auto-a)',
        mode = 'n'
      },
      {
        '<Leader>wrd',
        '<Plug>(operator-sandwich-replace)',
        mode = 'x'
      },
    }, --}}}
  },
  {
    'FooSoft/vim-argwrap',
    keys = {
      { '<Leader>x', '<Plug>(ArgWrapToggle)' },
    },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'go',
        callback = function() vim.b.argwrap_tail_comma = 1 end,
      })
    end,
  },
  {
    'ziontee113/syntax-tree-surfer',
    lazy = false,
    init = function()
      require('syntax-tree-surfer').setup()
      keymap('n', '<Leader><Leader><', '<Cmd>STSSwapUpNormal<CR>', ko)
      keymap('n', '<Leader><Leader>>', '<Cmd>STSSwapDownNormal<CR>', ko)
      keymap('n', '<Leader>>', '<Cmd>STSSwapCurrentNodeNextNormal<CR>', ko)
      keymap('n', '<Leader><', '<Cmd>STSSwapCurrentNodePrevNormal<CR>', ko)
      keymap('x', '<Leader>>', '<Cmd>STSSwapNextVisual<CR>', ko)
      keymap('x', '<Leader><', '<Cmd>STSSwapPrevVisual<CR>', ko)
      keymap("x", "J", '<cmd>STSSelectNextSiblingNode<cr>', ko)
      keymap("x", "K", '<cmd>STSSelectPrevSiblingNode<cr>', ko)
      keymap("x", "H", '<cmd>STSSelectParentNode<cr>', ko)
      keymap("x", "L", '<cmd>STSSelectChildNode<cr>', ko)
    end,
  },
  {
    "kiyoon/treesitter-indent-object.nvim",
    keys = {
      {
        "ai",
        function() require 'treesitter_indent_object.textobj'.select_indent_outer() end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer)",
      },
      {
        "aI",
        function() require 'treesitter_indent_object.textobj'.select_indent_outer(true) end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer, line-wise)",
      },
      {
        "ii",
        function() require 'treesitter_indent_object.textobj'.select_indent_inner() end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, partial range)",
      },
      {
        "iI",
        function() require 'treesitter_indent_object.textobj'.select_indent_inner(true, 'V') end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
      },
    },
  },
  {
    -- comment
    'numToStr/Comment.nvim',
    keys = {
      'gc',
      'gb',
      { 'gc', mode = 'o' },
      { 'gb', mode = 'o' },
      { 'gc', mode = 'x' },
      { 'gb', mode = 'x' },
    },
    config = function()
      require('Comment').setup({})
    end,
  },
  --}}}
  --{{{ Undo
  {
    'simnalamburt/vim-mundo',
    keys = {
      { '<Space>u', '<Cmd>MundoToggle<CR>' },
    },
  },
  --}}}
  --{{{ Memo
  {
    'glidenote/memolist.vim',
    keys = {
      { '<Leader>mn', '<Cmd>MemoNew<CR>' }
    },
    init = function()
      vim.g.memolist_path = "~/Dropbox/memo"
      vim.g.memolist_memo_suffix = "txt"
      vim.g.memolist_memo_date = "%Y-%m-%d %H:%M"
    end,
  },
  --}}}
  --{{{ Diff tools
  {
    'AndrewRadev/linediff.vim',
    cmd = {
      'Linediff',
      'LinediffAdd',
    }
  },
  {
    'will133/vim-dirdiff',
    cmd = {
      'DirDiff',
    },
    config = function()
      keymap('n', '[<C-d>', '<Cmd>DirDiffPrev<CR>', ko_s)
      keymap('n', ']<C-d>', '<Cmd>DirDiffNext<CR>', ko_s)
    end,
  },
  --}}}
  --{{{ Appearance
  {
    'norcalli/nvim-colorizer.lua',
    lazy = false,
  },
  --}}}
  --{{{ Highlights
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        parser_install_dir = vim.g.treesitter_parser_dir,
        ignore_install = { --{{{
          'ada',
          'agda',
          'arduino',
          -- 'astro',
          -- 'awk',
          -- 'bash',
          'bass',
          'beancount',
          'bibtex',
          'bicep',
          'blueprint',
          -- 'c',
          -- 'c_sharp',
          'capnp',
          'chatito',
          'clojure',
          -- 'cmake',
          -- 'comment',
          'commonlisp',
          'cooklang',
          'cpon',
          -- 'cpp',
          -- 'css',
          -- 'cuda',
          'cue',
          'd',
          -- 'dart',
          'devicetree',
          'dhall',
          'diff',
          -- 'dockerfile',
          -- 'dot',
          'ebnf',
          'eex',
          'elixir',
          'elm',
          'elsa',
          'elvish',
          'embedded_template',
          'erlang',
          'fennel',
          'firrtl',
          'fish',
          'foam',
          'fortran',
          'fsh',
          'func',
          'fusion',
          'gdscript',
          -- 'git_config',
          -- 'git_rebase',
          -- 'gitattributes',
          -- 'gitcommit',
          -- 'gitignore',
          'gleam',
          'glimmer',
          'glsl',
          -- 'go',
          'godot_resource',
          -- 'gomod',
          -- 'gosum',
          -- 'gowork',
          -- 'graphql',
          'hack',
          'hare',
          'haskell',
          -- 'hcl',
          'heex',
          -- 'help',
          'hjson',
          'hlsl',
          'hocon',
          -- 'html',
          'htmldjango',
          -- 'http',
          'ini',
          -- 'java',
          -- 'javascript',
          -- 'jq',
          -- 'jsdoc',
          -- 'json',
          -- 'json5',
          -- 'jsonc',
          -- 'jsonnet',
          'julia',
          'kdl',
          -- 'kotlin',
          'lalrpop',
          -- 'latex',
          'ledger',
          'llvm',
          -- 'lua',
          -- 'luadoc',
          -- 'luap',
          'm68k',
          -- 'make',
          -- 'markdown',
          -- 'markdown_inline',
          -- 'matlab',
          'menhir',
          -- 'mermaid',
          'meson',
          'mlir',
          'nickel',
          'ninja',
          'nix',
          'norg',
          'ocaml',
          'ocaml_interface',
          'ocamllex',
          'org',
          'pascal',
          'passwd',
          -- 'perl',
          'php',
          'phpdoc',
          'pioasm',
          'po',
          'poe_filter',
          'pony',
          -- 'prisma',
          -- 'proto',
          'prql',
          'pug',
          -- 'python',
          'ql',
          'qmldir',
          'qmljs',
          'query',
          'r',
          'racket',
          'rasi',
          'regex',
          'rego',
          'rnoweb',
          'ron',
          'rst',
          -- 'ruby',
          -- 'rust',
          -- 'scala',
          'scheme',
          -- 'scss',
          'slint',
          'smali',
          'smithy',
          'solidity',
          'sparql',
          -- 'sql',
          'squirrel',
          'starlark',
          'supercollider',
          'surface',
          'svelte',
          'swift',
          'sxhkdrc',
          't32',
          'tablegen',
          'teal',
          -- 'terraform',
          'thrift',
          'tiger',
          'tlaplus',
          'todotxt',
          -- 'toml',
          -- 'tsx',
          'turtle',
          'twig',
          -- 'typescript',
          'ungrammar',
          'uxntal',
          'v',
          'vala',
          'verilog',
          'vhs',
          -- 'vim',
          -- 'vue',
          'wgsl',
          'wgsl_bevy',
          -- 'yaml',
          'yang',
          'yuck',
          'zig',
        }, --}}}
        ensure_installed = 'all',
        highlight = {
          enable = true,
        },
        indent = {
          enable = false,
        },
      };
    end
  },
  {
    'brenoprata10/nvim-highlight-colors',
    lazy = false,
    init = function()
      require('nvim-highlight-colors').setup()
    end,
  },
  --}}}
  --{{{ FileType plugins
  -- CSV
  {
    'mechatroner/rainbow_csv',
    ft = 'csv',
  },
  -- Go
  {
    'rhysd/vim-goyacc',
    ft = 'goyacc',
  },
  -- Markdown
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'plantuml', 'mermaid' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_command_for_global = 1
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_theme = 'light'
    end,
  },
  {
    'aklt/plantuml-syntax',
    ft = { 'markdown', 'plantuml' },
  },
  -- Web
  {
    'windwp/nvim-ts-autotag',
    ft = {
      -- https://github.com/windwp/nvim-ts-autotag/tree/main#default-values
      'html',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'vue',
      'tsx',
      'jsx',
      'rescript',
      'xml',
      'php',
      'markdown',
      'astro',
      'glimmer',
      'handlebars',
      'hbs',
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-ts-autotag').setup({})
    end,
  },
  --}}}
  --{{{ Status bar
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        disabled_filetypes = {
          status_line = {
            'NvimTree',
          },
          winbar = {
            'NvimTree',
          },
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', {
          'diagnostics',
          source = { 'nvim_lsp' },
          sections = { 'error', 'warn' },
          symbols = {
            error = 'E',
            warn  = 'W',
            info  = 'I',
            hint  = 'H',
          },
        },
        },
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        'nvim-tree',
        'nvim-dap-ui',
        'quickfix',
      },
    },
  },
  --}}}
  --{{{ Color Scheme
  {
    'cocopon/iceberg.vim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('iceberg')
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "LineNr" })
    end,
  },
  --}}}
}, {
  defaults = {
    lazy = true,
  },
})

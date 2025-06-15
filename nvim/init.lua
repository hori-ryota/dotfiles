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
vim.opt.list = false
vim.opt.number = true
--}}}
--{{{ 5 syntax, highlighting and spelling
vim.opt.hlsearch = true
vim.cmd.nohlsearch()
vim.opt.spell = true
vim.opt.spellcapcheck = ''
vim.opt.spelloptions = { 'camel', 'noplainbuffer' }
vim.opt.spelllang:append('cjk')
local spellfile_dir = vim.fn.stdpath('config') .. '/spell'
if vim.fn.isdirectory(spellfile_dir) == 0 then
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
vim.opt.smarttab = true
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

file_type_detect('CMakeLists.txt', 'cmake')
file_type_detect('*.{txt,text}', 'markdown')
file_type_detect('*.marp.md', 'markdown.marp')
file_type_detect({ '*.env', '*.env.*' }, 'sh')
file_type_detect({ 'envrc', 'envrc.*' }, 'zsh')
file_type_detect({ 'zlogin', 'zlogout', 'zpreztorc', 'zprofile', 'zshenv', 'zshrc' }, 'zsh')
file_type_detect('*.go.y', 'goyacc')
file_type_detect('*.uml', 'plantuml')
file_type_detect('*.mmd', 'mermaid')
file_type_detect('*.vim.local', 'vim')
file_type_detect('*.lua.local', 'lua')
file_type_detect('*.dockerignore', 'dockerignore')
file_type_detect('*Dockerfile*', 'dockerfile')
file_type_detect({ 'tsconfig.json', 'tsconfig.*.json', 'eslintrc', 'eslintrc.json', 'tasks.json', 'extensions.json' },
  'jsonc')
file_type_detect({ 'settings.json' }, 'jsonc')
file_type_detect('editorconfig', 'editorconfig')
file_type_detect({ 'gitconfig', 'gitconfig.*', '.gitconfig.*' }, 'gitconfig')
file_type_detect({ 'gitignore', 'gitignore.*', '.gitignore.*' }, 'gitignore')
file_type_detect('*.hcl', 'hcl')
file_type_detect({ '.terraformrc', 'terraform.rc' }, 'hcl')
file_type_detect({ '*.tf', '*.tfvars' }, 'terraform')
file_type_detect({ '*.tfstate', '*.tfstate.backup' }, 'hcl')
file_type_detect('buf.*gen.md', 'yaml.bufgen')
--}}}

--{{{ install lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
  'antoinemadec/FixCursorHold.nvim', -- for https://github.com/antoinemadec/FixCursorHold.nvim/issues/13 for neotest
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
      'saghen/blink.cmp',
      'j-hui/fidget.nvim',
      'folke/snacks.nvim',
    },
    lazy = false,
    config = function()
      vim.api.nvim_create_augroup('MyLspConfig', {})
      vim.diagnostic.config({ --{{{
        virtual_text = {
          source = true,
          prefix = '',
        },
      }); --}}}

      keymap('n', '<Leader>L', '<Cmd>LspRestart<CR>', ko)

      --{{{ [\[gopls\] delay diagnostics or not run them in insert mode · Issue \#127 · neovim/nvim\-lspconfig](https://github.com/neovim/nvim-lspconfig/issues/127)
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.handlers.on_publish_diagnostics, {
        -- delay update diagnostics
        update_in_insert = false,
      });
      --}}}

      local function bind_key_map() --{{{
        local function picker(f)
          return function()
            Snacks.picker[f]()
          end
        end
        keymap('n', '<Leader>ll', vim.lsp.codelens.run, ko_sb)
        keymap('n', '<Leader>lL', function() vim.diagnostic.open_float({ focusable = false }) end, ko_sb)
        keymap('n', '[f', vim.diagnostic.goto_prev, ko_sb)
        keymap('n', ']f', vim.diagnostic.goto_next, ko_sb)
        keymap('n', '<Space>lf', picker('diagnostics'), ko_sb)
        keymap('n', 'K', vim.lsp.buf.hover, ko_sb)
        keymap('n', '<Space><Tab>', vim.lsp.buf.signature_help, ko_sb)
        keymap('n', '<C-]>', picker('lsp_definitions'), ko_sb)
        keymap('n', '<Leader>li', picker('lsp_implementations'), ko_sb)
        keymap('n', '<Leader>lc', picker('lsp_references'), ko_sb)
        keymap('n', '<Leader>lR', vim.lsp.buf.rename, ko_sb)
        keymap('n', '<Leader>la', vim.lsp.buf.code_action, ko_sb)
        keymap('v', '<Leader>la', vim.lsp.buf.code_action, ko_sb)
        keymap('n', 'gq', vim.lsp.buf.format, ko_sb)
        keymap('v', 'gq', vim.lsp.buf.format, ko_sb)
        keymap('n', '<Leader>ws', picker('lsp_workspace_symbols'), ko_sb)
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

      local capabilities = require('blink.cmp').get_lsp_capabilities()

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
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              -- use SchemaStore.nvim instead
              enable = false,
              url = "",
            },
            schemas = require('schemastore').yaml.schemas({
              extra = {
                {
                  description = "Taskfile files",
                  fileMatch = { "Taskfile.*.yaml", "Taskfile.*.yml" },
                  name = "Taskfile config",
                  url = "https://taskfile.dev/schema.json"
                }
              },
            }),
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
      lspconfig.ruff.setup({
        capabilities = capabilities,
        on_attach = function()
          keymap('n', 'gQ', function()
            vim.lsp.buf.code_action({
              context = {
                only = {
                  "source.fixAll.ruff",
                },
              },
              apply = true,
            })
          end, ko_b)
        end,
      })
      lspconfig.basedpyright.setup({
        capabilities = capabilities,
        root_markers = { 'pyproject.toml' },
        cmd = { 'sh', '-c', 'uv run --quiet basedpyright-langserver --stdio || basedpyright-langserver --stdio' },
        settings = {
          python = {
            venvPath = ".",
            pythonPath = "./.venv/bin/python",
            analysis = {
              extraPaths = { "." },
              autoImportCompletions = true,
              autoSearchPaths = true,
            }
          }
        },
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
              '-**/.pnpm-store',
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
              vendor = false,
            },
            ---- UI Completion ----
            usePlaceholders = true,
            ---- UI Diagnostic ----
            analyses = {
              unusedparams = false,
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
      lspconfig.golangci_lint_ls.setup({
        capabilities = capabilities,
        init_options = (function()
          local handle = io.popen(
            "golangci-lint --version 2>/dev/null | grep -o 'version [0-9]\\+\\.[0-9]\\+\\.[0-9]\\+' | cut -d' ' -f2")
          local version = handle and handle:read("*a"):gsub("%s+$", "") or ""
          if handle then handle:close() end

          local major_version = tonumber(version:match("^(%d+)%."))

          if major_version and major_version < 2 then
            return {
              command = {
                "golangci-lint",
                "run",
                "--out-format",
                "json",
                "--issues-exit-code=1",
              }
            }
          end

          return {}
        end)(),
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
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        root_markers = { "package.json" },
        single_file_support = false,
        -- use prettier as formatter
        on_attach = disable_formatter
      })
      lspconfig.biome.setup({
        capabilities =
            vim.tbl_deep_extend('force', capabilities, {
              textDocument = {
                positionEncoding = { 'utf-16' }
              }
            }),

        cmd = { 'na', 'exec', 'biome', 'lsp-proxy' },
        on_attach = function()
          keymap('n', 'gQ', "<Cmd>execute '!na exec biome check --write --unsafe ' . shellescape(expand('%:p'))<CR>",
            ko_b)
          fmt_on_save()
        end,
        workspace_required = true,
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
        on_attach = function(client)
          disable_formatter(client)
          keymap('n', 'gQ', '<Cmd>EslintFixAll<CR><Cmd>lua vim.lsp.buf.format()<CR>', ko_b)
        end,
        workspace_required = true,
      })
      lspconfig.prismals.setup({
        capabilities = capabilities,
      })
      --}}}

      --{{{ for Astro
      lspconfig.astro.setup({
        capabilities = capabilities,
        root_markers = { 'astro.config.ts' },
        on_attach = function()
          fmt_on_save()
        end,
        workspace_required = true,
      })
      --}}}

      --{{{ for Deno
      lspconfig.denols.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        on_attach = function()
          fmt_on_save()
          vim.opt_local.makeprg = 'deno run -A %'
        end,
      })
      --}}}

      --{{{ for Sell Scripts
      lspconfig.bashls.setup({
        on_attach = function(_, bufnr)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          if string.match(filename, "%.env$") or string.match(filename, "%.env%..*$") then
            vim.diagnostic.disable(bufnr)
          end
        end,
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

      --{{{ for Proto
      lspconfig.buf_ls.setup({
        capabilities = capabilities,
      })
      --}}}

      --{{{ for cmake
      lspconfig.neocmake.setup({
        capabilities = capabilities,
      })
      --}}}

      --{{{ for C/C++
      lspconfig.clangd.setup({
        capabilities = capabilities,
        filetypes = {
          'c',
          'cpp',
          'objc',
          'objcpp',
          'cuda',
          -- 'proto',
        },
      })
      --}}}

      --}}}
    end,
  }, --}}}
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
    },
    lazy = false,
    config = function()
      require('null-ls').setup({
        diagnostics_format = '[#{c}] #{m} (#{s})',
        update_in_insert = false,
        sources = {
          -- Makefile
          require('null-ls').builtins.diagnostics.checkmake.with({
            filter = function(diagnostic)
              if diagnostic.message:match('Missing required phony target "all"') or
                  diagnostic.message:match('Missing required phony target "clean"') then
                return false
              end
              return true
            end,
          }),
          -- Dockerfile
          require('null-ls').builtins.diagnostics.hadolint,
          -- sh
          require('null-ls').builtins.formatting.shfmt,
          -- prettier
          require('null-ls').builtins.formatting.prettier.with({
            condition = function()
              local file_dir = vim.fn.expand('%:p:h')
              return vim.fn.findfile('biome.jsonc', file_dir .. ';') == '' and
                  vim.fn.findfile('biome.json', file_dir .. ';') == ''
            end,
          }),
          -- Go
          require('null-ls').builtins.code_actions.gomodifytags,
          require('null-ls').builtins.code_actions.impl,
          require('null-ls').builtins.formatting.goimports.with({
            extra_args = function()
              local local_imports = os.getenv("GO_IMPORTS_LOCAL")
              if local_imports then
                return { "-local", local_imports }
              end
              return {}
            end,
          }),
          -- GitHub Action
          require('null-ls').builtins.diagnostics.actionlint,

          -- { "go", "javascript", "lua", "python", "typescript" }
          require('null-ls').builtins.code_actions.refactoring,
        },
      })
    end,
  },
  {
    'nvimtools/none-ls-extras.nvim',
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
    'saghen/blink.cmp',
    version = '*',
    event = {
      'InsertEnter',
      'CmdlineEnter',
    },
    opts = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },
      completion = {
        documentation = { auto_show = true },
        keyword = { range = 'prefix' },
      },
      sources = {
        default = {
          'snippets',
          'lsp',
          'path',
          'buffer',
        },
        providers = {
          path = {
            timeout_ms = 1000,
            max_items = 1000,
          },
        },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
      snippets = { preset = 'luasnip' },
      signature = { enabled = true },
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
    cmd = 'Copilot',
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
            ratio = 0.4,
          },
        },
      })
      -- vim.api.nvim_command('highlight link CopilotSuggestion Comment')
    end,
  },
  --}}}
  --{{{ AI
  {
    'olimorris/codecompanion.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup({
        opts = {
          language = "Japanese",
        },
        adapters = {
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              schema = {
                model = {
                  default = "gemini-2.5-pro-preview-05-06",
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = 'gemini',
            keymaps = {
              send = {
                modes = { n = '<CR>', i = '<C-q>' },
              },
              close = {
                modes = { n = '<Space>at' },
              },
            },
          },
          inline = {
            adapter = 'gemini',
            keymaps = {
              accept_change = {
                modes = { n = '<Leader>aa' },
              },
              reject_change = {
                modes = { n = '<Leader>ad' },
              },
            },
          },
          cmd = {
            adapter = 'gemini',
          },
        },
        display = {
          action_palette = {
            provider = 'snacks',
          },
          chat = {
            show_settings = true,
          },
        },
        extensions = {
          mcphub = {
            callback = 'mcphub.extensions.codecompanion',
            opts = {
              show_result_in_chat = true,
              make_vars = true,
              make_slash_commands = true,
            },
          },
        },
      })

      vim.api.nvim_create_augroup('MyCodeCompanion', {})
      vim.api.nvim_create_autocmd('FileType', {
        group = 'MyCodeCompanion',
        pattern = 'codecompanion',
        callback = function()
          keymap('n', '<C-d>', 'i@full_stack_dev<CR>', ko)
          keymap('i', '<C-d>', '@full_stack_dev<CR>', ko)
          keymap('n', '<C-v>', 'i#viewport<CR>', ko)
          keymap('i', '<C-v>', '#viewport<CR>', ko)
          vim.opt_local.makeprg = vim.fn.expand('%:p')
        end,
      })
    end,
    keys = {
      { '<Space>at', '<Cmd>CodeCompanionChat Toggle<CR>' },
      { '<Space>aa', ':CodeCompanionActions<CR>',              mode = { 'n', 'x' }, },
    },
  },
  {
    'ravitemer/mcphub.nvim',
    config = function()
      require('mcphub').setup()
    end,
  },
  --}}}
  --{{{ snacks.nvim
  {
    'folke/snacks.nvim',
    lazy = false,
    config = function()
      vim.cmd('hi! link SnacksPickerDir Comment')
      require('snacks').setup({
        picker = {
          ui_select = true,
          win = {
            input = {
              keys = {
                ['x'] = { 'select_and_next', mode = { 'n' } },
              },
            },
          },
        },
      })
    end,
    keys = {
      { '<Space><Space>', function() Snacks.picker.smart() end },
      { '<Space>b',       function() Snacks.picker.buffers() end },
      { '<Space>r',       function() Snacks.picker.grep() end },

      { '<Space>h',       function() Snacks.picker.help() end },
      { '<Space>k',       function() Snacks.picker.keymaps() end },

      { '<Space>vs',      function() Snacks.picker.git_status() end },
      { '<Space>vl',      function() Snacks.picker.git_log() end },
      { '<Space>vd',      function() Snacks.picker.git_diff() end },
      { '<Space>vL',      function() Snacks.picker.git_log_file() end },
      { '<Space>v<C-l>',  function() Snacks.picker.git_log_line() end },

      { '<Space>ml',      function() Snacks.picker.files({ cwd = vim.g.memolist_path }) end },
      { '<Space>mr',      function() Snacks.picker.grep({ cwd = vim.g.memolist_path }) end },

      { '<Space>sl',      function() Snacks.picker.files({ cwd = os.getenv('HOME') .. '/.dotfiles' }) end },
      { '<Space>sr',      function() Snacks.picker.grep({ cwd = os.getenv('HOME') .. '/.dotfiles' }) end },
    },
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
        add_trailing = true,
        indent_markers = {
          enable = true,
        },
        icons = {
          git_placement = 'signcolumn',
        },
        special_files = {
          "Cargo.toml",
          "Makefile",
          "README.md",
          "readme.md",
          "Taskfile.toml",
          "Taskfile.dist.toml",
        },
      },
      filesystem_watchers = {
        ignore_dirs = {
          "/.cache",
          "/.ccls-cache",
          "/.git",
          "/.local",
          "/.task",
          "/.terraform",
          "/build",
          "/node_modules",
          "/target",
        },
      },
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function apply(keys, target, desc)
          vim.keymap.set('n', keys, target,
            { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true })
        end
        local function toggleTreeOrOpen()
          local core = require('nvim-tree.core')
          local explorer = core.get_explorer()
          if not explorer then
            return
          end
          local view = require('nvim-tree.view')
          local action = 'edit'
          local node = explorer:get_node_at_cursor()

          if node.link_to and not node.nodes then
            require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
            view.close() -- Close the tree if file was opened
          elseif node.nodes ~= nil then
            node:expand_or_collapse()
          else
            require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
            view.close() -- Close the tree if file was opened
          end
        end

        apply('o', toggleTreeOrOpen, 'toggle tree or open')
        apply('<CR>', toggleTreeOrOpen, 'toggle tree or open')
        apply('!', api.node.run.cmd, 'cmd open')
        apply('g!', api.node.run.system, 'system open')
        apply('R', function()
          local node = api.tree.get_node_under_cursor()
          local buf = vim.fn.bufadd(node.absolute_path)
          vim.fn.bufload(buf)
          local makeprg = vim.bo[buf].makeprg
          require('overseer').run_template({
            name = 'shell',
            params = {
              cmd = makeprg,
            },
          })
          require('overseer').open()
        end, 'run on overseer')

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
          local node = api.tree.get_node_under_cursor()
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
  --{{{ Async Execution
  {
    'stevearc/overseer.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    init = function()
      require('overseer').setup({
        templates = { "shell_scripts", "buf", "builtin" },
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
            ["R"] = "<Cmd>OverseerQuickAction restart<CR>",
            ["W"] = "<Cmd>OverseerQuickAction watch<CR>",
            ["D"] = "<Cmd>OverseerQuickAction stop<CR>",
          },
          direction = "bottom",
          min_height = 20,
        },
        components = {
          { "on_complete_dispose", timeout = 3600 },
        },
      })
      keymap('n', '<Space>o', '<Cmd>OverseerToggle<CR>', ko)
      keymap('n', '<Leader>o', '<Cmd>OverseerRun<CR>', ko)

      local overseer = require('overseer')

      keymap('n', '<Leader>r', function()
        overseer.run_template({
          name = 'shell',
          params = {
            cmd = vim.opt.makeprg:get(),
            -- to set vim.opt_local.makeprg each filetype
          },
        })
        overseer.open()
      end, ko)

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local tasks = overseer.list_tasks({ recent_first = true })
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
      keymap('n', '<Leader>R', '<Cmd>OverseerRestartLast<CR>', ko)

      vim.api.nvim_create_augroup('MyOverseer', {})
      vim.api.nvim_create_autocmd('FileType', {
        group = 'MyOverseer',
        pattern = 'sh',
        callback = function()
          vim.opt_local.makeprg = vim.fn.expand('%:p')
        end,
      })

      keymap('n', '<Leader><Leader>r', function()
        overseer.run_template({
          name = 'shell',
          params = {
            cmd = '',
            cwd = vim.fn.expand('%:h'),
          },
          prompt = 'always',
        })
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
        ["<Leader>kg"] = "go generate",
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
      keymap('n', '<Leader>ja', function()
        overseer.run_template({
          name = 'shell',
          params = {
            cmd = 'uv add ',
            cwd = vim.fn.expand('%:h'),
          },
          prompt = 'always',
        })
      end, ko)
      keymap('n', '<Leader>bg', function()
        overseer.run_template({
          name = 'shell',
          params = {
            cmd = 'buf generate --template=' .. vim.fn.expand('%:t'),
            cwd = vim.fn.expand('%:h'),
          },
        })
        overseer.open()
      end, ko)

      local function terraform_dir()
        local dir = os.getenv('TERRAFORM_DIR')
        if not dir then
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
      'nvim-neotest/nvim-nio',
      'antoinemadec/FixCursorHold.nvim',
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
        virtual_text = false,
      }, neotest_ns)
      require('neotest').setup({
        discovery = {
          enabled = false,
        },
        -- your neotest config here
        adapters = {
          require('neotest-golang')({
            testify_enabled = true,
          }),
          -- require('neotest-python'),
          -- require('neotest-jest'),
          -- require('neotest-vitest'),
          -- require('neotest-playwright').adapter({
          --   options = {
          --     enable_dynamic_test_discovery = true,
          --   },
          -- }),
          -- require('neotest-dart'),
        },
        -- consumers = {
        --   playwright = require("neotest-playwright.consumers").consumers,
        -- },
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
            jumpto = '<C-]>',
            mark = 'x',
            clear_marked = 'X',
            run = 'r',
            run_marked = 'R',
            short = 'P',
            output = 'go',
          },
        },
      })
    end,
  },
  'nvim-neotest/nvim-nio',
  {
    'fredrikaverpil/neotest-golang',
  },
  -- 'nvim-neotest/neotest-python',
  -- 'haydenmeade/neotest-jest',
  -- 'marilari88/neotest-vitest',
  -- 'thenbe/neotest-playwright',
  -- 'sidlatau/neotest-dart',
  -- -- NOTE: neotest-denoはまだWIPな模様（README.mdにWIPと記載、docに `*neotest.config*` がありhelptagsが本体との重複で失敗する）
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
        '<Leader>wr',
        '<Plug>(operator-sandwich-replace)' ..
        '<Plug>(operator-sandwich-release-count)' ..
        '<Plug>(textobj-sandwich-query-a)',
        mode = 'n'
      },
      {
        '<Leader>wrb',
        '<Plug>(operator-sandwich-replace)' ..
        '<Plug>(operator-sandwich-release-count)' .. '<Plug>(textobj-sandwich-auto-a)',
        mode = 'n'
      },
      {
        '<Leader>wr',
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
  {
    -- comment
    'tris203/hawtkeys.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    lazy = false,
    config = function()
      require('hawtkeys').setup({})
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
          'latex',
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
          'php_only',
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
  -- for configuration files
  {
    'b0o/SchemaStore.nvim',
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

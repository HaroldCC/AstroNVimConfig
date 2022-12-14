--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below
-- vim.cmd("set redrawtime=10000")
vim.cmd "syntax enable"
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
        let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        set shellquote= shellxquote=
  ]]
-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

-- 复制内容高亮
vim.cmd [[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup END
]]
-- normal 和 insert 模式自动切换输入法
vim.cmd [[autocmd InsertLeave * :silent :!im-select 1033]]
vim.cmd [[autocmd InsertEnter * :silent :!im-select 2052]]

-- 上下移动选中---
vim.cmd [[
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
]]

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme to use
  colorscheme = "default_theme",

  -- Override highlight groups in any theme
  highlights = {
    --   Normal = { bg = "#000000" },
    -- duskfox = { -- a table of overrides/changes to the default
    -- },
    default_theme = function(highlights) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      highlights.Normal = {
        fg = C.fg,
        bg = C.bg,
      }
      return highlights
    end,
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = false, -- sets vim.opt.relativenumber
      tabstop = 4,
      shiftwidth = 4,
      expandtab = true,
      list = true,
      listchars = "space:·,tab:▷▷⋮",
      foldcolumn = "5",
      foldlevel = 99,
      foldlevelstart = 99,
      foldenable = true,
      so = 1,
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
    },
  },
  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,

  -- Set dashboard header
  header = {
    " █████  ███████ ████████ ██████   ██████",
    "██   ██ ██         ██    ██   ██ ██    ██",
    "███████ ███████    ██    ██████  ██    ██",
    "██   ██      ██    ██    ██   ██ ██    ██",
    "██   ██ ███████    ██    ██   ██  ██████",
    " ",
    "    ███    ██ ██    ██ ██ ███    ███",
    "    ████   ██ ██    ██ ██ ████  ████",
    "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
    "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
    "    ██   ████   ████   ██ ██      ██",
  },

  -- Default theme configuration
  default_theme = {
    -- set the highlight style for diagnostic messages
    diagnostics_style = {
      italic = true,
    },
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    skip_setup = { "clangd" },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        ["<leader>lf"] = false, -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
      -- Example disabling formatting for a specific language server
      -- gopls = { -- override table for require("lspconfig").gopls.setup({...})
      --   on_attach = function(client, bufnr)
      --     client.resolved_capabilities.document_formatting = false
      --   end
      -- }
      clangd = {
        capabilities = {
          offsetEncoding = "utf-8",
        },
      },
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      ["<leader>d"] = { "" },
      ["<S-h>"] = { "H" },
      ["<S-l>"] = { "L" },
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      ["<leader>bb"] = {
        "<cmd>tabnew<cr>",
        desc = "New tab",
      },
      ["<leader>bc"] = {
        "<cmd>BufferLinePickClose<cr>",
        desc = "Pick to close",
      },
      ["<leader>bj"] = {
        "<cmd>BufferLinePick<cr>",
        desc = "Pick to jump",
      },
      ["<leader>bt"] = {
        "<cmd>BufferLineSortByTabs<cr>",
        desc = "Sort by tabs",
      },
      -- quick save
      ["<C-s>"] = {
        ":w!<cr>",
        desc = "Save File",
      }, -- change description but the same command

      ["<leader>sw"] = {
        [[:%s/\<<C-R><C-W>\>//g<left><left>]],
        desc = "匹配单词重命名",
      },
      -- 左右比例控制
      ["<"] = { ":vertical resize +2<CR>" },
      [">"] = { ":vertical resize -2<CR>" },
      -- 上下比例
      ["sj"] = { ":resize +2<CR>" },
      ["sk"] = { ":resize -2<CR>" },
      -- 等比例
      ["s="] = { "<C-w>=" },

      ['""'] = { 'mQlbi"<ESC>ea"<ESC>`Ql' },
      ["<C-p>"] = { "<cmd>Telescope find_files<CR>" },
      ["<C-h>"] = { '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>' },
      -- tab切换
      ["<leader><tab>"] = {
        "<cmd>BufferLineCycleNext<CR>",
        desc = "下一个页签",
      },
      ["<leader><leader><tab>"] = {
        "<cmd>BufferLineCyclePrev<CR>",
        desc = "上一个页签",
      },
      ["<leader>of"] = {
        ":!start explorer %:h<CR>",
        desc = "打开当前文件的文件夹",
      },
      ["<C-o>"] = {
        "<cmd>AerialOpen<CR>",
        desc = "打开大纲",
      },

      -- diffview
      ["<leader>df"] = {
        "<cmd>DiffviewOpen<CR>",
        desc = "打开对比",
      },
      ["<leader>dh"] = {
        "<cmd>DiffviewFileHistory %<CR>",
        desc = "对比文件历史",
      },

      -- format
      ["<leader>f"] = {
        "<cmd>lua vim.lsp.buf.formatting()<CR>",
        desc = "格式化文档",
      },

      -- diagnostic
      ["g["] = {
        "<cmd>lua vim.diagnostic.goto_next()<CR>",
        desc = "下一个诊断",
      },
      ["g]"] = {
        "<cmd>lua vim.diagnostic.goto_prev()<CR>",
        desc = "上一个诊断",
      },

      ["<C-z>"] = { "u" },

      ["<A-o>"] = { "<cmd>ClangdSwitchSourceHeader<CR>" },
    },
    i = {
      ["<C-s>"] = { "<Esc>:w!<CR>" },
      ["jk"] = { "<ESC>" },
      ["<C-z>"] = { "<ESC>u" },
    },
    v = {
      ["."] = { ":normal! .<CR>" },
      ["dd"] = { '"_dd' },
      ["daw"] = { '"_daw' },
      ["dw"] = { '"_dw' },
      ["D"] = { '"_D' },
      ['di"'] = { '"_di"' },
      ["di("] = { '"_di(' },
      ["di{"] = { '"_di{' },

      ["<leader>dd"] = { '"+dd' },
      ["<leader>daw"] = { '"+daw' },
      ["<leader>dw"] = { '"+dw' },
      ["<leader>D"] = { '"+D' },
      ['<leader>di"'] = { '"+di"' },
      ["<leader>di("] = { '"+di(' },
      ["<leader>di{"] = { '"+di{' },
      -- 在visual 模式里粘贴不要复制
      ["p"] = { '"_dP' },

      -- 格式化
      ["<leader>f"] = {
        "<cmd>lua vim.lsp.buf.formatting_sync()<CR>",
        desc = "格式化选定内容",
      },
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- Configure plugins
  plugins = {
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- Add plugins, the packer syntax without the "use"
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },

      -- We also support a key value style plugin definition similar to NvChad:
      -- ["ray-x/lsp_signature.nvim"] = {
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
      ["chentoast/marks.nvim"] = { config = function() require("marks").setup() end },
      ["sindrets/diffview.nvim"] = {
        config = function() require "user.my_plugins.diffview" end,
        requires = { { "nvim-lua/plenary.nvim" }, { "kyazdani42/nvim-web-devicons" } },
        after = "plenary.nvim",
        cmd = {
          "DiffviewOpen",
          "DiffviewFileHistory",
          "DiffviewClose",
          "DiffviewToggleFiles",
          "DiffviewFocusFiles",
          "DiffviewRefresh",
        },
      },

      -- clangd
      {
        "p00f/clangd_extensions.nvim",
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
          require("clangd_extensions").setup {
            server = astronvim.lsp.server_settings "clangd",
          }
        end,
      },

      ["kylechui/nvim-surround"] = {
        config = function()
          require("nvim-surround").setup {
            -- Configuration here, or leave empty to use defaults
          }
        end,
      },

      ["glepnir/lspsaga.nvim"] = {
        branch = "main",
      },
      --  ["anuvyklack/hydra.nvim"] = {
      --      config = require "user.my_plugins.hydra"
      --  },
      ["ray-x/lsp_signature.nvim"] = {},

      ["kevinhwang91/nvim-ufo"] = {
        requires = "kevinhwang91/promise-async",
        config = function() require "user.my_plugins.nvim-ufo" end,
      },

      ["nvim-telescope/telescope.nvim"] = {
       requires = {
         { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
        config = function() require("telescope").load_extension("live_grep_args") end,
      },
    },

    -- ⚠️  Overrides default config
    ["lspkind"] = require "user.my_plugins.lspkind",
    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup functino call
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
      }
      -- set up null-ls's on_attach function
      -- NOTE: You can remove this on attach function to disable format on save
      -- config.on_attach = function(client)
      --   if client.resolved_capabilities.document_formatting then
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       desc = "Auto format before save",
      --       pattern = "<buffer>",
      --       callback = vim.lsp.buf.formatting_sync,
      --     })
      --   end
      -- end
      return config -- return final config table to use in require("null-ls").setup(config)
    end,
    treesitter = { -- overrides `require("treesitter").setup(...)`
      ensure_installed = { "lua", "cpp" },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = { "sumneko_lua, clangd" },
    },
    -- use mason-tool-installer to configure DAP/Formatters/Linter installation
    ["mason-tool-installer"] = { -- overrides `require("mason-tool-installer").setup(...)`
      ensure_installed = { "prettier", "stylua" },
    },
    ["telescope"] = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
    },

    ["cmp"] = require "user.my_plugins.cmp",

    ["neo-tree"] = require "user.my_plugins.neo-tree",
    packer = { -- overrides `require("packer").setup(...)`
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = {
            name = "Buffer",
          },
        },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", {
      clear = true,
    })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

-- 自定义按键映射，不添加到which-key中
local map = vim.keymap.set
local opt = {
  noremap = true,
  silent = true,
}
map("n", "vv", "<C-v>", opt)
-- 删除设置
map("n", "dd", '"_dd', opt)
map("n", "daw", '"_daw', opt)
map("n", "dw", '"_dw', opt)
map("n", "D", '"_D', opt)
map("n", 'di"', '"_di"', opt)
map("n", "di(", '"_di(', opt)
map("n", "di{", '"_di{', opt)

map("n", "<leader>dd", '"+dd', opt)
map("n", "<leader>daw", '"+daw', opt)
map("n", "<leader>dw", '"+dw', opt)
map("n", "<leader>D", '"+D', opt)
map("n", '<leader>di"', '"+di"', opt)
map("n", "<leader>di(", '"+di(', opt)
map("n", "<leader>di{", '"+di{', opt)

map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-l>", "<C-w>l", opt)

return config

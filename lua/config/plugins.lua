return { -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end
{ -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    opts = {
        icons = {
            -- set icon mappings to true if you have a Nerd Font
            mappings = vim.g.have_nerd_font,
            -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
            -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
            keys = vim.g.have_nerd_font and {} or {
                Up = "<Up> ",
                Down = "<Down> ",
                Left = "<Left> ",
                Right = "<Right> ",
                C = "<C-…> ",
                M = "<M-…> ",
                D = "<D-…> ",
                S = "<S-…> ",
                CR = "<CR> ",
                Esc = "<Esc> ",
                ScrollWheelDown = "<ScrollWheelDown> ",
                ScrollWheelUp = "<ScrollWheelUp> ",
                NL = "<NL> ",
                BS = "<BS> ",
                Space = "<Space> ",
                Tab = "<Tab> ",
                F1 = "<F1>",
                F2 = "<F2>",
                F3 = "<F3>",
                F4 = "<F4>",
                F5 = "<F5>",
                F6 = "<F6>",
                F7 = "<F7>",
                F8 = "<F8>",
                F9 = "<F9>",
                F10 = "<F10>",
                F11 = "<F11>",
                F12 = "<F12>"
            }
        },

        -- Document existing key chains
        spec = {{
            "<leader>c",
            group = "[C]ode",
            mode = {"n", "x"}
        }, {
            "<leader>d",
            group = "[D]ocument"
        }, {
            "<leader>r",
            group = "[R]ename"
        }, {
            "<leader>s",
            group = "[S]earch"
        }, {
            "<leader>w",
            group = "[W]orkspace"
        }, {
            "<leader>t",
            group = "[T]oggle"
        }, {
            "<leader>h",
            group = "[H]op"
        }}
    }
}, -- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin
{ -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {"nvim-lua/plenary.nvim",
                    { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
            return vim.fn.executable("make") == 1
        end
    }, {"nvim-telescope/telescope-ui-select.nvim"}, -- Useful for getting pretty icons, but requires a Nerd Font.
    {
        "nvim-tree/nvim-web-devicons",
        enabled = vim.g.have_nerd_font
    }},
    config = function()
        -- Telescope is a fuzzy finder that comes with a lot of different things that
        -- it can fuzzy find! It's more than just a "file finder", it can search
        -- many different aspects of Neovim, your workspace, LSP, and more!
        --
        -- The easiest way to use Telescope, is to start by doing something like:
        --  :Telescope help_tags
        --
        -- After running this command, a window will open up and you're able to
        -- type in the prompt window. You'll see a list of `help_tags` options and
        -- a corresponding preview of the help.
        --
        -- Two important keymaps to use while in Telescope are:
        --  - Insert mode: <c-/>
        --  - Normal mode: ?
        --
        -- This opens a window that shows you all of the keymaps for the current
        -- Telescope picker. This is really useful to discover what Telescope can
        -- do as well as how to actually do it!

        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
        require("telescope").setup({
            -- You can put your default mappings / updates / etc. in here
            --  All the info you're looking for is in `:help telescope.setup()`
            --
            -- defaults = {
            --   mappings = {
            --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            --   },
            -- },
            -- pickers = {}
            extensions = {
                ["ui-select"] = {require("telescope.themes").get_dropdown()}
            }
        })

        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, {
            desc = "[S]earch [H]elp"
        })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, {
            desc = "[S]earch [K]eymaps"
        })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, {
            desc = "[S]earch [F]iles"
        })
        vim.keymap.set("n", "<leader>ss", builtin.builtin, {
            desc = "[S]earch [S]elect Telescope"
        })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, {
            desc = "[S]earch current [W]ord"
        })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, {
            desc = "[S]earch by [G]rep"
        })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {
            desc = "[S]earch [D]iagnostics"
        })
        vim.keymap.set("n", "<leader>sr", builtin.resume, {
            desc = "[S]earch [R]esume"
        })
        vim.keymap.set("n", "<leader>s.", builtin.oldfiles, {
            desc = '[S]earch Recent Files ("." for repeat)'
        })
        vim.keymap.set("n", "<leader><leader>", builtin.buffers, {
            desc = "[ ] Find existing buffers"
        })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false
            }))
        end, {
            desc = "[/] Fuzzily search in current buffer"
        })

        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files"
            })
        end, {
            desc = "[S]earch [/] in Open Files"
        })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set("n", "<leader>sn", function()
            builtin.find_files({
                cwd = vim.fn.stdpath("config")
            })
        end, {
            desc = "[S]earch [N]eovim files"
        })
    end
}, -- LSP Plugins
{
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = { -- Load luvit types when the `vim.uv` word is found
        {
            path = "luvit-meta/library",
            words = {"vim%.uv"}
        }}
    }
}, {
    "Bilal2453/luvit-meta",
    lazy = true
}, {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = { -- Automatically install LSPs and related tools to stdpath for Neovim
    {
        "williamboman/mason.nvim",
        config = true
    }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim", -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
        "j-hui/fidget.nvim",
        opts = {}
    }, -- Allows extra capabilities provided by nvim-cmp
    "hrsh7th/cmp-nvim-lsp"},
    config = function()
        -- Brief aside: **What is LSP?**
        --
        -- LSP is an initialism you've probably heard, but might not understand what it is.
        --
        -- LSP stands for Language Server Protocol. It's a protocol that helps editors
        -- and language tooling communicate in a standardized fashion.
        --
        -- In general, you have a "server" which is some tool built to understand a particular
        -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
        -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
        -- processes that communicate with some "client" - in this case, Neovim!
        --
        -- LSP provides Neovim with features like:
        --  - Go to definition
        --  - Find references
        --  - Autocompletion
        --  - Symbol Search
        --  - and more!
        --
        -- Thus, Language Servers are external tools that must be installed separately from
        -- Neovim. This is where `mason` and related plugins come into play.
        --
        -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
        -- and elegantly composed help section, `:help lsp-vs-treesitter`

        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", {
                clear = true
            }),
            callback = function(event)
                -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, {
                        buffer = event.buf,
                        desc = "LSP: " .. desc
                    })
                end

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                -- Find references for the word under your cursor.
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", {"n", "x"})

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", {
                        clear = false
                    })
                    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight
                    })

                    vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", {
                            clear = true
                        }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({
                                group = "kickstart-lsp-highlight",
                                buffer = event2.buf
                            })
                        end
                    })
                end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({
                            bufnr = event.buf
                        }))
                    end, "[T]oggle Inlay [H]ints")
                end
            end
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        -- ! Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local servers = {
            -- clangd = {},
            gopls = {},
            astro = {},
            biome = {},
            codespell = {},
            cssls = {},
            css_variables = {},
            denols = {},
            eslint = {},
            gofumpt = {},
            goimports = {},
            golines = {},
            html = {},
            htmx = {},
            jsonlint = {},
            jsonls = {},
            stylua = {},
            markdownlint = {},
            marksman = {},
            mdx_analyzer = {},
            prettierd = {},
            shfmt = {},
            sqlfmt = {},
            sqls = {},
            svelte = {},
            tailwindcss = {},
            taplo = {},
            ts_ls = {},
            zls = {},
            -- pyright = {},
            rust_analyzer = {},
            -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
            --
            -- Some languages (like typescript) have entire language plugins that can be useful:
            --    https://github.com/pmizio/typescript-tools.nvim
            --
            -- But for many setups, the LSP (`ts_ls`) will work just fine
            -- ts_ls = {},
            --

            lua_ls = {
                -- cmd = {...},
                -- filetypes = { ...},
                -- capabilities = {},
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        }
                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                        -- diagnostics = { disable = { 'missing-fields' } },
                    }
                }
            }
        }

        -- Ensure the servers and tools above are installed
        --  To check the current status of installed tools and/or manually install
        --  other tools, you can run
        --    :Mason
        --
        --  You can press `g?` for help in this menu.
        require("mason").setup()

        -- ! You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {}) -- Inside the brackets, add tools to install
        require("mason-tool-installer").setup({
            ensure_installed = ensure_installed
        })

        require("mason-lspconfig").setup({
            handlers = {function(server_name)
                local server = servers[server_name] or {}
                -- This handles overriding only values explicitly passed
                -- by the server configuration above. Useful when disabling
                -- certain features of an LSP (for example, turning off formatting for ts_ls)
                server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                require("lspconfig")[server_name].setup(server)
            end}
        })
    end
}, { -- Autoformat
    "stevearc/conform.nvim",
    event = {"BufWritePre"},
    cmd = {"ConformInfo"},
    keys = {{
        "<leader>f",
        function()
            require("conform").format({
                async = true,
                lsp_format = "fallback"
            })
        end,
        mode = "",
        desc = "[F]ormat buffer"
    }},
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = {
                c = true,
                cpp = true
            }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = "never"
            else
                lsp_format_opt = "fallback"
            end
            return {
                timeout_ms = 500,
                lsp_format = lsp_format_opt
            }
        end,
        formatters = {
            stylua = {
                prepend_args = {"--indent-type", "Spaces", "--indent-width", "2"}
            },
            prettier = {
                prepend_args = {"--use-tabs", "false", "--tab-width", "2"}
            }
            -- Add configuration for other formatters here
        },
        formatters_by_ft = {
            -- Conform can also run multiple formatters sequentially
            -- python = { "isort", "black" },
            --
            -- You can use 'stop_after_first' to run the first available formatter from the list
            html = {"prettier"},
            css = {"prettier"},
            scss = {"prettier"},
            javascript = {"prettier"},
            typescript = {"prettier"},
            javascriptreact = {"prettier"},
            typescriptreact = {"prettier"},
            json = {"prettier"},
            yaml = {"prettier"},
            markdown = {"prettier"},
            svelte = {"prettier"},
            vue = {"prettier"},

            -- Backend
            lua = {"stylua"},
            golang = {"gofumpt", "goimports"},
            rust = {"rustfmt"},

            -- Config files
            toml = {"taplo"},

            -- Shell scripts
            sh = {"shfmt"}
        }
    }
}, { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { -- Snippet Engine & its associated nvim-cmp source
    {
        "L3MON4D3/LuaSnip",
        build = (function()
            -- Build Step is needed for regex support in snippets.
            -- This step is not supported in many windows environments.
            -- Remove the below condition to re-enable on windows.
            if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                return
            end
            return "make install_jsregexp"
        end)(),
        dependencies = { -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end
        }}
    }, "saadparwaiz1/cmp_luasnip", -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path"},
    config = function()
        -- See `:help cmp`
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.setup({})

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            completion = {
                completeopt = "menu,menuone,noinsert"
            },

            -- For an understanding of why these mappings were
            -- chosen, you will need to read `:help ins-completion`
            --
            -- No, but seriously. Please read `:help ins-completion`, it is really good!
            mapping = cmp.mapping.preset.insert({
                -- Select the [n]ext item
                ["<C-n>"] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ["<C-p>"] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ["<C-y>"] = cmp.mapping.confirm({
                    select = true
                }),

                -- If you prefer more traditional completion keymaps,
                -- you can uncomment the following lines
                -- ['<CR>'] = cmp.mapping.confirm { select = true },
                -- ['<Tab>'] = cmp.mapping.select_next_item(),
                -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ["<C-Space>"] = cmp.mapping.complete({}),

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, {"i", "s"}),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, {"i", "s"})

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            }),
            sources = {{
                name = "lazydev",
                -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                group_index = 0
            }, {
                name = "nvim_lsp"
            }, {
                name = "luasnip"
            }, {
                name = "path"
            }}
        })
    end
}, { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "catppuccin/nvim",
    config = function()
        require("catppuccin").setup({
            flavour = "auto", -- latte, frappe, macchiato, mocha
            background = {
                light = "latte",
                dark = "mocha"
            },
            transparent_background = true, -- Set this to true for transparent background
            show_end_of_buffer = false,
            term_colors = false,
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15
            },
            no_italic = false,
            no_bold = false,
            no_underline = false,
            styles = {
                comments = {"italic"},
                conditionals = {"italic"},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {}
            },
            color_overrides = {},
            custom_highlights = {},
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                    enabled = true,
                    indentscope_color = ""
                }
            }
        })
    end,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
        -- Load the colorscheme here.
        -- Like many other themes, this one has different styles, and you could load
        -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
        vim.cmd.colorscheme("catppuccin")

        -- You can configure highlights by doing something like:
        vim.cmd.hi("Comment gui=none")
    end
}, -- Highlight todo, notes, etc in comments
{
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = {"nvim-lua/plenary.nvim"},
    opts = {
        signs = false
    }
}, { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({
            n_lines = 500
        })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        local statusline = require("mini.statusline")
        -- set use_icons to true if you have a Nerd Font
        statusline.setup({
            use_icons = vim.g.have_nerd_font
        })

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return "%2l:%-2v"
        end

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
    end
}, { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
        ensure_installed = {"bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim",
                            "vimdoc"},
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
            enable = true,
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = {"ruby"}
        },
        indent = {
            enable = true,
            disable = {"ruby"}
        }
    }
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}, {
    "goolord/alpha-nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Function to get the current time-based greeting
        local function get_greeting()
            local hour = tonumber(os.date("%H"))
            local name = "RATIU5"

            if hour >= 5 and hour < 12 then
                return string.format("Good morning, %s.", name)
            elseif hour >= 12 and hour < 18 then
                return string.format("Good afternoon, %s.", name)
            else
                return string.format("Good evening, %s.", name)
            end
        end

        -- Function to create a box around text
        local function create_box(text)
            local len = #text
            local top_bottom = "╭" .. string.rep("─", len + 2) .. "╮"
            local middle = "│ " .. text .. " │"
            local bottom = "╰" .. string.rep("─", len + 2) .. "╯"
            return {top_bottom, middle, bottom}
        end

        local greeting = get_greeting()
        local boxed_greeting = create_box(greeting)

        dashboard.section.header.val = {"", "", boxed_greeting[1], boxed_greeting[2], boxed_greeting[3], "", ""}

        dashboard.section.buttons.val = {dashboard.button("n", "   New file", ":ene <BAR> startinsert <CR>"),
                                         dashboard.button("f", "   Find file",
            ":cd $HOME/Developer | Telescope find_files<CR>"),
                                         dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
                                         dashboard.button("s", "   Settings",
            ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"), dashboard.button("q", "   Quit NVIM", ":qa<CR>")}

        -- Function to get plugin load time
        local function get_plugin_load_time()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return string.format("⚡ Neovim loaded %d plugins in %.2f ms", stats.count, ms)
        end

        -- Set up the footer with plugin load time
        dashboard.section.footer.val = get_plugin_load_time()
        dashboard.section.footer.opts.hl = "Comment"

        dashboard.config.opts.noautocmd = true

        vim.cmd([[autocmd User AlphaReady echo 'ready']])

        alpha.setup(dashboard.config)
    end
}, {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons", "meuter/lualine-so-fancy.nvim"},
    opts = {
        options = {
            theme = "auto",
            component_separators = {
                left = "│",
                right = "│"
            },
            section_separators = {
                left = "",
                right = ""
            },
            globalstatus = true,
            refresh = {
                statusline = 100
            }
        },
        sections = {
            lualine_a = {{
                "fancy_mode",
                width = 3
            }},
            lualine_b = {{"fancy_branch"}, {"fancy_diff"}},
            lualine_c = {{
                "fancy_cwd",
                substitute_home = true
            }},
            lualine_x = {{"fancy_macro"}, {"fancy_diagnostics"}, {"fancy_searchcount"}, {"fancy_location"}},
            lualine_y = {{
                "fancy_filetype",
                ts_icon = ""
            }},
            lualine_z = {{"fancy_lsp_servers"}}
        }
    }
}, {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = { -- 👇 in this section, choose your own keymappings!
    {
        "<leader>e",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file"
    }, {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory"
    }, {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session"
    }},
    opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = false,
        keymaps = {
            show_help = "<f1>"
        }
    }
}, { -- Git integration
    "lewis6991/gitsigns.nvim",
    event = {"BufReadPre", "BufNewFile"},
    opts = {
        signs = {
            add = {
                text = "│"
            },
            change = {
                text = "│"
            },
            delete = {
                text = "_"
            },
            topdelete = {
                text = "‾"
            },
            changedelete = {
                text = "~"
            },
            untracked = {
                text = "┆"
            }
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1
        },
        yadm = {
            enable = false
        }
    }
}, {
    "folke/todo-comments.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}, {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
        local hop = require('hop')
        local directions = require('hop.hint').HintDirection
        hop.setup {
            keys = 'etovxqpdygfblzhckisuran'
        }
    end
}}

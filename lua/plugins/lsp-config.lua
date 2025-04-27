return {
-- mason installation
    {
        priority = 1000,
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

-- mason-lspconfig installation
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "ruff" },
            })
        end,
    },
    
-- nvim-lspconfig installation
    {
        "neovim/nvim-lspconfig",
        dependencies = {"williamboman/mason-lspconfig.nvim"},

        config = function()
            require("lspconfig").pyright.setup({
                on_new_config = function(new_config, root_dir)
                        local util = require("lspconfig.util") 
                        local venv = util.path.join(root_dir, ".venv") -- Path to the venv folder
                        if util.path.exists(venv) then
                            new_config.settings = new_config.settings or {}
                            new_config.settings.python = new_config.settings.python or {}

                            new_config.settings.python.analysis = { 
                                ignore = { '*' }, 
                                typeCheckingMode = "off"
                            }
                            new_config.settings.pyright = { disableOrganizeImports = true }

                            new_config.settings.python.venvPath = root_dir -- Directory containing the venv
                            new_config.settings.python.venv = ".venv" -- Name of the venv folder
                            new_config.settings.python.pythonPath = util.path.join(venv, "bin", "python") -- Path to the Python interpreter
                        end
                    end,
            })
            
            -- Keybindings and autocommands
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                local buf = args.buf
                
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

                -- Keybindings
                local opts = { buffer = buf }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- Show references
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Show documentation
                vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts) -- Rename symbol
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions
                end,
            })
        end,
    },
}

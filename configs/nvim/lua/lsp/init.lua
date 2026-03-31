-- Collect all tools from manually required configs
local tools_to_install = {}
vim.list_extend(tools_to_install, require('lsp.lua').ensure_installed)

-- Setup mason with all collected tools
require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
  ensure_installed = tools_to_install
})


vim.opt.completeopt = vim.opt.completeopt + "noselect"
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, {
                autotrigger = true,
                fuzzy_matching = true,
                debounce = 50
            })
		end
	end,
})

vim.api.nvim_create_autocmd({"InsertEnter", "CursorMovedI"}, {
    callback = function()
        vim.defer_fn(function()
            vim.lsp.completion.get()
        end, 50)
    end,
  desc = "Auto completion on insert events"
})

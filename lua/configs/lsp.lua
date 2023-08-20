local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local protocol = require("vim.lsp.protocol")

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function(client, bufnr)
	-- format on save
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Format", { clear = true }),
			buffer = bufnr,
		})
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Clangd
nvim_lsp.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,

	cmd = {
		"clangd",
		"--enable-config",
		"--query-driver=/usr/bin/*g++*",
		-- "--compile-commands-dir=./debug",
	},
	filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp" },
	root_dir = function()
		return vim.loop.cwd()
	end,
	extraArgs = {
		"-I",
		"/usr/include/c++/11/",
	},
})

-- Cmake
nvim_lsp.cmake.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- TypeScript
nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- CSS
nvim_lsp.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Tailwind
nvim_lsp.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- HTML
nvim_lsp.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- JSON
nvim_lsp.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Eslint
nvim_lsp.eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Python
nvim_lsp.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Rust
nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

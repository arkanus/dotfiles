-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    update_in_insert = true,
    virtual_text = true,

    -- put virtual text into quickfix list
    -- replaced by <leader>ll mapping

    --    virtual_text = function(buf, client_id)
    --        local diagnostics = vim.lsp.diagnostic.get_all()
    --        local qflist = {}
    --        for bufnr, diagnostic in pairs(diagnostics) do
    --          for _, d in ipairs(diagnostic) do
    --            d.bufnr = bufnr
    --            d.lnum = d.range.start.line + 1
    --            d.col = d.range.start.character + 1
    --            d.text = d.message
    --            table.insert(qflist, d)
    --          end
    --        end
    --        vim.lsp.util.set_qflist(qflist)
    --        return {spacing = 4, prefix = '❰'}
    --    end
}) 

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

local function setup_servers()
    require'lspinstall'.setup()

    -- Default config for new servers

    -- local servers = require'lspinstall'.installed_servers()
    -- for _, server in pairs(servers) do
    --     require'lspconfig'[server].setup{on_attach = require('lsp').on_attach}
    -- end

    -- Load specific server configs
    require("lsp.csharp")
    require("lsp.lua")
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = "/home/marcos/.local/share/nvim/lspinstall/csharp/./omnisharp/run"
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"

-- flags stolen from how vscode runs omnisharp (ps ux|grep omni)
-- so it canm find godot stuff
local flags = "\
-z \
-s /home/marcos/Godot/csharp_experiment/csharp_experiment.sln DotNet:enablePackageRestore=false \
--encoding utf-8 \
--loglevel information \
--plugin \
/home/marcos/.vscode-oss/extensions/muhammad-sammy.csharp-1.23.12/.razor/OmniSharpPlugin/Microsoft.AspNetCore.Razor.OmniSharpPlugin.dll \
FileOptions:SystemExcludeSearchPatterns:0=**/.git \
FileOptions:SystemExcludeSearchPatterns:1=**/.svn \
FileOptions:SystemExcludeSearchPatterns:2=**/.hg \
FileOptions:SystemExcludeSearchPatterns:3=**/CVS \
FileOptions:SystemExcludeSearchPatterns:4=**/.DS_Store"

require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid), flags },
    on_attach = require('lsp').on_attach
}

-- Add local plugins to runtimepath
vim.opt.rtp:append(vim.fn.stdpath("config") .. "/lua/plugins/local/toggle_char.nvim")

-- Build hook: run :TSUpdate after treesitter installs or updates
-- Must be registered before vim.pack.add()
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      vim.schedule(function()
        vim.cmd("TSUpdate")
      end)
    end
  end,
})

vim.pack.add({
  -- Shared dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/kevinhwang91/promise-async",
  "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",

  -- Plugins (alphabetical)
  "https://github.com/MaximilianLloyd/ascii.nvim",
  "https://github.com/eandrju/cellular-automaton.nvim",
  "https://github.com/olimorris/codecompanion.nvim",
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/saecki/crates.nvim",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/echasnovski/mini.comment",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/norcalli/nvim-colorizer.lua",
  "https://github.com/windwp/nvim-spectre",
  "https://github.com/chrisgrieser/nvim-spider",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/kevinhwang91/nvim-ufo",
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range(">=6") },
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/todo-comments.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/MeanderingProgrammer/treesitter-modules.nvim", version = "main" },
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/Mofiqul/vscode.nvim",
  "https://github.com/folke/which-key.nvim",
}, { confirm = false })

-- vim-tmux-navigator is a Vimscript plugin; explicitly source its plugin/ files
vim.cmd.packadd("vim-tmux-navigator")

-- Load all plugin configurations
require("plugins")

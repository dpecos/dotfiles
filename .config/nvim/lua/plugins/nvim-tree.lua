-- Nvim Tree
-- https://github.com/nvim-tree/nvim-tree.lua
--
-- File explorer tree with git integration, icons, and auto-sync across tabs
-- Keymaps: Ctrl+n (toggle), <leader>n (find file), <leader>r (refresh)
-- Custom keybindings: v (vsplit), h (hsplit), a (create), d (delete), r (rename)
-- Auto-opens when starting Neovim without a file and closes when last buffer

local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  local map = require("utils.keymap").map

  local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

  map("<CR>", api.node.open.edit, "nvim-tree", "Open", opts)
  map("v", api.node.open.vertical, "nvim-tree", "Open: Vertical Split", opts)
  map("h", api.node.open.horizontal, "nvim-tree", "Open: Horizontal Split", opts)
  map("<Tab>", api.node.open.preview, "nvim-tree", "Open Preview", opts)
  map("<2-LeftMouse>", api.node.open.edit, "nvim-tree", "Open", opts)

  map("a", api.fs.create, "nvim-tree", "Create", opts)
  map("yy", api.fs.copy.node, "nvim-tree", "Copy", opts)
  map("Y", api.fs.copy.relative_path, "nvim-tree", "Copy Relative Path", opts)
  map("gy", api.fs.copy.filename, "nvim-tree", "Copy Name", opts)
  map("gY", api.fs.copy.absolute_path, "nvim-tree", "Copy Absolute Path", opts)
  map("p", api.fs.paste, "nvim-tree", "Paste", opts)
  map("d", api.fs.remove, "nvim-tree", "Delete", opts)
  map("r", api.fs.rename, "nvim-tree", "Rename", opts)

  map(">", api.node.navigate.sibling.next, "nvim-tree", "Next Sibling", opts)
  map("<", api.node.navigate.sibling.prev, "nvim-tree", "Previous Sibling", opts)
  map("K", api.node.show_info_popup, "nvim-tree", "Info", opts)
  map("H", api.tree.toggle_hidden_filter, "nvim-tree", "Toggle Dotfiles", opts)
  map("?", api.tree.toggle_help, "nvim-tree", "Help", opts)
end

local setup = function()
  require("nvim-tree").setup({
    hijack_cursor = true,
    view = {
      width = 50,
    },
    tab = {
      sync = {
        open = true,
        close = true,
      },
    },
    renderer = {
      group_empty = true,
      icons = {
        web_devicons = {
          file = {
            enable = true,
            color = true,
          },
          folder = {
            enable = false,
            color = true,
          },
        },
      }
    },
    filters = {
      dotfiles = false,
      custom = { "\\.git$", "node_modules" },
    },
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    actions = {
      use_system_clipboard = true,
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    git = {
      enable = true,
      ignore = false,
    },
    on_attach = on_attach,
  })

  local api = require("nvim-tree.api")
  local map = require("utils.keymap").map

  map("<C-n>", api.tree.toggle, "NvimTree", "Toggle file explorer")
  map("<leader>r", ":NvimTreeRefresh<CR>", "NvimTree", "Refresh file explorer")
  map("<leader>n", ":NvimTreeFindFile<CR>", "NvimTree", "Show current file in explorer")

  -- close vim if nvim-tree is the last buffer
  local function tab_win_closed(winnr)
    local api = require("nvim-tree.api")
    local tabnr = vim.api.nvim_win_get_tabpage(winnr)
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local buf_info = vim.fn.getbufinfo(bufnr)[1]
    local tab_wins = vim.tbl_filter(function(w)
      return w ~= winnr
    end, vim.api.nvim_tabpage_list_wins(tabnr))
    local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
    if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
      -- Close all nvim tree on :q
      if not vim.tbl_isempty(tab_bufs) then        -- and was not the last window (not closed automatically by code below)
        api.tree.close()
      end
    else                                                    -- else closed buffer was normal buffer
      if #tab_bufs == 1 then                                -- if there is only 1 buffer left in the tab
        local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
        if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
          vim.schedule(function()
            if #vim.api.nvim_list_wins() == 1 then          -- if its the last buffer in vim
              vim.cmd("quit")                               -- then close all of vim
            else                                            -- else there are more tabs open
              vim.api.nvim_win_close(tab_wins[1], true)     -- then close only the tab
            end
          end)
        end
      end
    end
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(data)
      local IGNORED_FT = {
        "gitcommit",
      }

      -- buffer is a real file on the disk
      local real_file = vim.fn.filereadable(data.file) == 1

      -- buffer is a [No Name]
      local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

      -- &ft
      local filetype = vim.bo[data.buf].ft

      -- real files do not open the tree
      if real_file or not no_name then
        return
      end

      -- skip ignored filetypes
      if vim.tbl_contains(IGNORED_FT, filetype) then
        return
      end

      -- open the tree but don't focus it
      require("nvim-tree.api").tree.toggle({ focus = false })
    end,
  })

  vim.api.nvim_create_autocmd("WinClosed", {
    callback = function()
      local winnr = tonumber(vim.fn.expand("<amatch>"))
      vim.schedule_wrap(tab_win_closed(winnr))
    end,
    nested = true,
  })
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "Mofiqul/vscode.nvim",
  },
  lazy = true,
  config = function()
    setup()
  end,
}

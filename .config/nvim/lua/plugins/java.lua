vim.pack.add({ "https://github.com/mfussenegger/nvim-jdtls" })

local function start_jdtls()
  local jdtls_ok, jdtls = pcall(require, "jdtls")
  if not jdtls_ok then
    vim.notify("nvim-jdtls not found. Run :MasonInstall jdtls", vim.log.levels.WARN, { title = "Java LSP" })
    return
  end

  -- Mason install path for jdtls
  local mason_pkg_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  local jdtls_bin = mason_pkg_path .. "/bin/jdtls"

  if vim.fn.executable(jdtls_bin) == 0 then
    vim.notify("jdtls not found at " .. jdtls_bin .. ". Run :MasonInstall jdtls", vim.log.levels.WARN, { title = "Java LSP" })
    return
  end

  -- Per-project workspace directory (jdtls stores metadata here)
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

  -- Determine OS-specific config directory inside the jdtls package
  local os_config = "config_linux"
  if vim.fn.has("mac") == 1 then
    os_config = "config_mac"
  elseif vim.fn.has("win32") == 1 then
    os_config = "config_win"
  end

  local config = {
    cmd = {
      jdtls_bin,
      "--jvm-arg=-javaagent:" .. mason_pkg_path .. "/lombok.jar",
      "-configuration", mason_pkg_path .. "/" .. os_config,
      "-data", workspace_dir,
    },

    root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

    settings = {
      java = {
        signatureHelp = { enabled = true },
        contentProvider = { preferred = "fernflower" },
        completion = {
          favoriteStaticMembers = {
            "org.junit.Assert.*",
            "org.junit.Assume.*",
            "org.junit.jupiter.api.Assertions.*",
            "org.junit.jupiter.api.Assumptions.*",
            "org.junit.jupiter.api.DynamicContainer.*",
            "org.junit.jupiter.api.DynamicTest.*",
            "org.mockito.Mockito.*",
            "org.mockito.ArgumentMatchers.*",
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
          useBlocks = true,
        },
        inlayHints = {
          parameterNames = {
            enabled = "all",
          },
        },
        format = {
          enabled = true,
        },
      },
    },

    init_options = {
      bundles = {},
    },

    on_attach = function(client, bufnr)
      local map = require("utils.keymap").map

      map("<leader>jo", function() jdtls.organize_imports() end, "Java", "Organize imports", { buffer = bufnr })
      map("<leader>jv", function() jdtls.extract_variable() end, "Java", "Extract variable", { buffer = bufnr })
      map("<leader>jV", function() jdtls.extract_variable(true) end, "Java", "Extract variable (range)", { buffer = bufnr, mode = "v" })
      map("<leader>jc", function() jdtls.extract_constant() end, "Java", "Extract constant", { buffer = bufnr })
      map("<leader>jC", function() jdtls.extract_constant(true) end, "Java", "Extract constant (range)", { buffer = bufnr, mode = "v" })
      map("<leader>jm", function() jdtls.extract_method(true) end, "Java", "Extract method (range)", { buffer = bufnr, mode = "v" })
      map("<leader>jt", function() jdtls.test_nearest_method() end, "Java", "Test nearest method", { buffer = bufnr })
      map("<leader>jT", function() jdtls.test_class() end, "Java", "Test class", { buffer = bufnr })
      map("<leader>ju", "<cmd>JdtUpdateConfig<CR>", "Java", "Update config", { buffer = bufnr })
    end,
  }

  jdtls.start_or_attach(config)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = start_jdtls,
})

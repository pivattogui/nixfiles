{ pkgs, ... }:
let
  oscura-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "oscura.nvim";
    version = "2025-03-20";
    src = pkgs.fetchFromGitHub {
      owner = "jwbaldwin";
      repo = "oscura.nvim";
      rev = "fa625cfc070c06dc00e5648316333a046e5822c0";
      hash = "sha256-q8ibFA/xTzRY3GjLt8nnMvTeqEbqSICQr7v1MlKJGu0=";
    };
  };
in
{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = (with pkgs.vimPlugins; [
      bufferline-nvim
      conform-nvim
      gitsigns-nvim
      lualine-nvim
      mini-nvim
      nvim-lspconfig
      (nvim-treesitter.withPlugins (p: with p; [
        bash
        eex
        elixir
        go
        gomod
        heex
        json
        lua
        markdown
        markdown_inline
        nix
        python
        regex
        toml
        tsx
        typescript
        vim
        vimdoc
        yaml
      ]))
      nvim-tree-lua
      nvim-web-devicons
      plenary-nvim
      telescope-nvim
      vim-sleuth
      which-key-nvim
    ]) ++ [
      oscura-nvim
    ];

    extraPackages = with pkgs; [
      # LSPs
      elixir-ls
      gopls
      nil
      pyright
      typescript-language-server

      # Formatters / linters
      alejandra
      biome
      ruff
    ];

    initLua = ''
      -- Options
      vim.opt.number = true
      vim.opt.cursorline = true
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.smartindent = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.incsearch = true
      vim.opt.scrolloff = 4
      vim.opt.splitbelow = true
      vim.opt.splitright = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.hidden = true
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 300

      -- Leader
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- Basic mappings
      vim.keymap.set("n", "<leader>w", "<cmd>bdelete<cr>", { desc = "Close buffer" })
      vim.keymap.set("n", "H", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
      vim.keymap.set("n", "L", "<cmd>bnext<cr>", { desc = "Next buffer" })
      vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
      vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

      vim.cmd.colorscheme("oscura")

      -- Treesitter
      -- nvim-treesitter 1.x (bundled with nvim 0.12) removed configs.setup().
      -- Highlighting is now driven by the native vim.treesitter API; indent via
      -- the module's indentexpr helper.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ok = pcall(vim.treesitter.start, args.buf)
          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- Diagnostics presentation
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
      })

      -- LspAttach: per-buffer keymaps + native completion
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local bufnr = ev.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gr", vim.lsp.buf.references, "Go to references")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "K",  vim.lsp.buf.hover, "Hover docs")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
          map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")

          -- Native completion (nvim 0.11+)
          if client and client.server_capabilities.completionProvider then
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
          end
        end,
      })

      -- LSP server setup (nvim-lspconfig v3 style: vim.lsp.config + vim.lsp.enable)
      vim.lsp.config("elixirls", { cmd = { "elixir-ls" } })
      vim.lsp.config("nil_ls", {
        -- Don't prompt to fetch missing flake inputs. The repo build
        -- (nh darwin switch) already fetches what's needed; nil_ls fetching
        -- on its own is redundant and interactive.
        settings = {
          ["nil"] = {
            nix = {
              flake = {
                autoArchive = false;
              };
            };
          };
        };
      })
      vim.lsp.enable({ "nil_ls", "ts_ls", "elixirls", "pyright", "gopls" })

      -- Format on save (conform.nvim)
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "biome" },
          javascriptreact = { "biome" },
          typescript = { "biome" },
          typescriptreact = { "biome" },
          json = { "biome" },
          jsonc = { "biome" },
          nix = { "alejandra" },
          python = { "ruff_format" },
          go = { "gofmt" },
          elixir = { "mix" },
        },
        format_on_save = {
          timeout_ms = 1000,
          lsp_format = "fallback",
        },
      })

      vim.keymap.set("n", "<leader>=", function()
        require("conform").format({ async = false, timeout_ms = 1000 })
      end, { desc = "Format buffer" })

      -- Telescope
      local telescope = require("telescope.builtin")
      vim.keymap.set("n", "<leader>f", telescope.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>g", telescope.live_grep, { desc = "Project grep" })
      vim.keymap.set("n", "<leader>b", telescope.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>cc", telescope.commands, { desc = "Commands" })
      vim.keymap.set("n", "<leader>/", telescope.current_buffer_fuzzy_find, { desc = "Search in buffer" })
      vim.keymap.set("n", "<leader>?", telescope.help_tags, { desc = "Help tags" })

      -- which-key (discoverability)
      require("which-key").setup({
        delay = 300,
        preset = "modern",
      })
      require("which-key").add({
        { "<leader>r", group = "refactor" },
        { "<leader>c", group = "code action / commands" },
        { "[",         group = "previous" },
        { "]",         group = "next" },
        { "g",         group = "goto" },
      })

      -- Bufferline
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = "thin",
          modified_icon = "●",
          offsets = {},
        },
      })

      -- Statusline (lualine)
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { { "filename", path = 1 }, { "diff" } },
          lualine_c = {
            "branch",
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return "" end
                local names = {}
                for _, c in ipairs(clients) do table.insert(names, c.name) end
                return table.concat(names, ", ")
              end,
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = "✗ ", warn = "⚠ ", info = "● ", hint = "○ " },
            },
          },
          lualine_x = {},
          lualine_y = { "location" },
          lualine_z = { "progress" },
        },
      })

      -- Gitsigns (gutter signs only — no inline blame, no popup)
      require("gitsigns").setup({
        signs = {
          add          = { text = "+" },
          change       = { text = "~" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = require("gitsigns")
          vim.keymap.set("n", "]c", function() gs.nav_hunk("next") end, { buffer = bufnr, desc = "Next git hunk" })
          vim.keymap.set("n", "[c", function() gs.nav_hunk("prev") end, { buffer = bufnr, desc = "Previous git hunk" })
        end,
      })

      -- mini.surround only (rest of mini.nvim is unused)
      require("mini.surround").setup({})

      -- File tree (nvim-tree). Sidebar on the left, mirrors the Zed/VS Code
      -- mental model. Disable netrw so it doesn't fight us for directory buffers.
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        view = { width = 32 },
        renderer = {
          group_empty = true,
          icons = {
            git_placement = "after",
          },
        },
        diagnostics = { enable = true },
        git = { enable = true },
        update_focused_file = { enable = true },
        actions = {
          open_file = { quit_on_open = false },
        },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
      vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFile<cr>", { desc = "Reveal current file in tree" })
    '';
  };
}

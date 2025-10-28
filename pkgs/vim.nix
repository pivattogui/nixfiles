{ pkgs, ... }:
let
  oscura-vim = pkgs.vimUtils.buildVimPlugin {
    pname = "oscura-vim";
    version = "2025-09-05";
    src = pkgs.fetchFromGitHub {
      owner = "vinitkumar";
      repo = "oscura-vim";
      rev = "e15e9938b11caeae6acbe6e9f7f5797cb7c3f0a8";
      hash = "sha256-4alAF3VesgmHvsQaOHGF+6fu50Ot0OB8N/izkXgdEC8=";
    };
  };
in
{
  programs.vim = {
    enable = true;
    defaultEditor = true;

    plugins =
      (with pkgs.vimPlugins; [
        vim-sensible
        vim-surround
        vim-fugitive
        vim-gitgutter
        vim-nix
        ale
        nerdtree
        lightline-vim
      ]) ++ [
        oscura-vim
      ];

    extraConfig = ''
      set number
      set cursorline
      set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
      syntax on
      filetype plugin indent on

      set tabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent

      set hidden
      set clipboard=unnamedplus
      set incsearch
      set ignorecase
      set smartcase
      set splitbelow
      set splitright
      set scrolloff=4
      set termguicolors
      set background=dark

      highlight Comment cterm=italic gui=italic

      let mapleader = " "
      nnoremap <leader>w :write<CR>
      nnoremap <leader>q :quit<CR>
      nnoremap <leader>ev :edit $MYVIMRC<CR>

      function! s:OscuraTransparent() abort
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight NormalFloat guibg=NONE ctermbg=NONE
        highlight FloatBorder guibg=NONE ctermbg=NONE
        highlight SignColumn guibg=NONE ctermbg=NONE
        highlight EndOfBuffer guibg=NONE ctermbg=NONE
      endfunction

      augroup OscuraOverrides
        autocmd!
        autocmd ColorScheme oscura-dusk call s:OscuraTransparent()
      augroup END

      try
        colorscheme oscura
        call s:OscuraTransparent()
      catch /^Vim\%((\a\+)\)\=:E185/
      endtry
    '';
  };
}

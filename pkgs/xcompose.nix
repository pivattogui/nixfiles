{ config, pkgs, ... }: {
  home.file.".XCompose".text = ''
    # Include default compose sequences
    include "%L"

    # Custom cedilha mapping: ' + c = ç, ' + C = Ç
    <apostrophe> <c> : "ç" ccedilla
    <apostrophe> <C> : "Ç" Ccedilla
  '';
}

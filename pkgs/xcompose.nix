_: {
  home.file.".XCompose".text = ''
    include "%L"

    # Cedilha: dead_acute + c/C = ç/Ç
    <dead_acute> <c> : "ç"
    <dead_acute> <C> : "Ç"
  '';
}

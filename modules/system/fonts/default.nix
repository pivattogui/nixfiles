{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      # jetbrains-mono - disabled due to python3.13-twisted build failure in nixpkgs
      # Use nerd-fonts.jetbrains-mono instead (includes the original + nerd font icons)
      nerd-fonts.jetbrains-mono
      inter
    ];
  };
}

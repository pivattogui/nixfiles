{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  agentPath = if isDarwin
    then "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else "~/.1password/agent.sock";
in
{
  home.file."1password-agent" = {
    enable = true;
    executable = false;

    target = ".config/1Password/ssh/agent.toml";
    text = ''
      [[ssh-keys]]
      vault = "Private"
    '';
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identityAgent = agentPath;
      };
    };
  };
}

{ config, pkgs, lib, ... }:

let
  claudeConfig = builtins.toJSON {
    mcpServers = {
      filesystem = {
        command = "npx";
        args = [ "-y" "@modelcontextprotocol/server-filesystem" config.home.homeDirectory ];
      };
      fetch = {
        command = "uvx";
        args = [ "mcp-server-fetch" ];
      };
      memory = {
        command = "npx";
        args = [ "-y" "@modelcontextprotocol/server-memory" ];
      };
      serena = {
        command = "uvx";
        args = [ "--from" "git+https://github.com/oraios/serena" "serena-mcp-server" "--enable-web-dashboard" "false" ];
      };
      chrome-devtools = {
        command = "npx";
        args = [ "-y" "chrome-devtools-mcp@latest" ];
      };
      sequential-thinking = {
        command = "npx";
        args = [ "-y" "@modelcontextprotocol/server-sequential-thinking" ];
      };
    };
  };
in
{
  home.activation.claudeConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config_file="${config.home.homeDirectory}/.claude.json"
    if [ ! -f "$config_file" ]; then
      echo '${claudeConfig}' > "$config_file"
    fi
  '';
}

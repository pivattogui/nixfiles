{ config, pkgs, lib, ... }:

{
  home.file.".claude.json".text = builtins.toJSON {
    mcpServers = {
      filesystem = {
        command = "npx";
        args = [ "-y" "@modelcontextprotocol/server-filesystem" config.home.homeDirectory ];
      };
      fetch = {
        command = "npx";
        args = [ "-y" "@modelcontextprotocol/server-fetch" ];
      };
      memory = {
        command = "npx";
        args = [ "-y" "@modelcontextprotocol/server-memory" ];
      };
      serena = {
        command = "uvx";
        args = [ "--from" "git+https://github.com/oraios/serena" "serena-mcp-server" ];
      };
    };
  };
}

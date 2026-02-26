{ config, lib, ... }:

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
  home.file.".claude/CLAUDE.md".text = ''
    # User Preferences

    ## Communication Style
    - Get right to the point, no sugar-coating
    - Use formal, professional tone
    - Only give exact answers when explicitly asked; otherwise provide details and reasoning

    ## Problem-Solving Approach
    - Be practical above all
    - Adopt a skeptical, questioning approach
    - Double-check all assumptions before proposing solutions
    - Keep things simple; question any complexity
    - Gather as much information as possible before answering

    ## Standards
    - Use metric system for all measurements
  '';

  home.activation.claudeConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config_file="${config.home.homeDirectory}/.claude.json"
    if [ ! -f "$config_file" ]; then
      echo '${claudeConfig}' > "$config_file"
    fi
  '';
}

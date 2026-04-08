{ ... }:
{
  programs.claude-code = {
    enable = true;

    # Conteúdo em ./claude-memory.md — diff legível, highlight, edição sem rebuild
    memory.text = builtins.readFile ./claude-memory.md;

    settings = {
      enabledPlugins = {
        "superpowers@claude-plugins-official" = true;
      };
    };

    mcpServers = {
      serena = {
        command = "nix";
        args = [ "shell" "nixpkgs#python3" "--command" "uvx" "--from" "git+https://github.com/oraios/serena" "serena" "start-mcp-server" "--enable-web-dashboard" "false" ];
      };
      linear = {
        command = "nix";
        args = [ "shell" "nixpkgs#nodejs" "--command" "npx" "-y" "mcp-remote" "https://mcp.linear.app/mcp" ];
      };
      context7 = {
        command = "nix";
        args = [ "shell" "nixpkgs#nodejs" "--command" "npx" "-y" "@upstash/context7-mcp" ];
      };
    };
  };
}

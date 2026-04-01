{ pkgs, ... }:
{
  programs.claude-code = {
    enable = true;

    memory.text = ''
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

    settings = {
      enabledPlugins = {
        "superpowers@claude-plugins-official" = true;
      };
    };

    mcpServers = {
      serena = {
        command = "${pkgs.lix}/bin/nix";
        args = [ "shell" "nixpkgs#python3" "--command" "uvx" "--from" "git+https://github.com/oraios/serena" "serena-mcp-server" "--enable-web-dashboard" "false" ];
      };
      linear = {
        command = "${pkgs.lix}/bin/nix";
        args = [ "shell" "nixpkgs#nodejs" "--command" "npx" "-y" "mcp-remote" "https://mcp.linear.app/mcp" ];
      };
    };
  };
}

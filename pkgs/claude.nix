{ pkgs, ... }:
{
  programs.claude-code = {
    enable = true;

    context = builtins.readFile ./claude-memory.md;

    mcpServers = {
      serena = {
        command = "${pkgs.uv}/bin/uvx";
        args = [ "--from" "git+https://github.com/oraios/serena" "serena" "start-mcp-server" "--enable-web-dashboard" "false" ];
      };
      linear = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [ "-y" "mcp-remote" "https://mcp.linear.app/mcp" ];
      };
      context7 = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [ "-y" "@upstash/context7-mcp" ];
      };
      datadog = {
        type = "http";
        url = "https://mcp.us5.datadoghq.com/api/unstable/mcp-server/mcp";
      };
    };
  };
}

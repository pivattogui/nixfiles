{ pkgs, ... }:
{
  home.packages = [ pkgs.diffnav ];

  programs.delta = {
    enable = true;
    enableGitIntegration = false;
    options = {
      navigate = true;
      dark = true;
      line-numbers = true;
      hyperlinks = true;
    };
  };

  programs.git = {
    enable = true;

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMTFatDlhYMwwYg+oad7tSthJi7LBho/8FF5Vwvls+bv";
      signByDefault = true;
    };

    settings = {
      user.name = "Pivatto";

      rerere = {
        enabled = true;
        autoUpdate = true;
      };
      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.verbose = true;
      core.editor = "nvim";
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      pager.diff = "diffnav --unified";

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      init.defaultBranch = "main";
      pull.rebase = true;

      merge.conflictStyle = "zdiff3";

      push = {
        autoSetupRemote = true;
        followTags = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      tag.sort = "version:refname";

      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
    };
  };
}

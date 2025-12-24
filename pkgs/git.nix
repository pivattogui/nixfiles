{ pkgs, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
  opSshSignPath = if isDarwin
    then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else "${pkgs._1password-gui}/share/1password/op-ssh-sign";
in
{
  programs.git = {
    enable = true;

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMTFatDlhYMwwYg+oad7tSthJi7LBho/8FF5Vwvls+bv";
      signByDefault = true;
    };

    settings = {
      user.name = "Pivatto";
      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.verbose = true;
      core.editor = "vim";

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
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

      color = {
        status = {
          added = "green";
          branch = "brightwhite bold";
          changed = "yellow";
          header = "white";
          untracked = "brightblack";
          unmerged = "red";
        };

        diff = {
          commit = "yellow bold";
          frag = "magenta bold";
          func = "146 bold";
          meta = "11";
          new = "green bold";
          old = "red bold";
          whitespace = "red reverse";
        };

        diff-highlight = {
          newHighlight = "green bold 22";
          newNormal = "green bold";
          oldHighlight = "red bold 52";
          oldNormal = "red bold";
        };
      };

      gpg = {
        format = "ssh";
        ssh.program = opSshSignPath;
      };
    };
  };

  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
}

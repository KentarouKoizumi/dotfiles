{ config, pkgs, ... }:

{
  home.username = "ke-koizumi";
  home.homeDirectory = "/home/ke-koizumi";

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    neovim
    nixfmt
    ripgrep
  ];

  home.file = {
  };

  home.sessionVariables = {
    BUN_INSTALL = "$HOME/.bun";
    # EDITOR = "emacs";
  };

  home.sessionPath = [
    "$HOME/.bun/bin"
  ];

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
    ];

    interactiveShellInit = ''
      set -g fish_key_bindings fish_vi_key_bindings
      set -g fish_sequence_key_delay_ms 200
    '';

    functions = {
      fish_user_key_bindings = ''
        # ノーマル(=command)モード: yy / Y で行コピーをクリップボードへ
        bind -M default yy fish_clipboard_copy
        bind -M default Y fish_clipboard_copy

        # ビジュアルモード: 選択範囲を y でクリップボードへ
        bind -M visual y fish_clipboard_copy

        # ノーマル(=command)モード: p でクリップボードから貼り付け
        bind -M default p fish_clipboard_paste

        # insert mode: jj で normal mode へ戻る
        bind -M insert -m default jj cancel repaint-mode
      '';
    };

    shellAbbrs = {
      ch = "sudo chown $USER -R .";
      chm = "sudo chmod 777 -R .";
      rbd = "git fetch origin develop && git rebase origin/develop";
      g-skip = "git update-index --skip-worktree";
      g-unskip = "git update-index --no-skip-worktree";
      g-skip-ls = "git ls-files -v | grep '^S' | cut -c3-";
      rmzone = "find . -type f -name \"*Zone.Identifier\" -delete";
      exp = "explorer.exe .";
    };
  };

  programs.bash = {
    enable = true;

    initExtra = ''
      if [[ $- == *i* ]] \
        && [[ -z "$BASH_EXECUTION_STRING" ]] \
        && [[ -z "$INSIDE_FISH" ]]
      then
        export INSIDE_FISH=1
        exec ${pkgs.fish}/bin/fish
      fi
    '';
  };
}

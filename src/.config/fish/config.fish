if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -f ~/.env
    while read -l line
        set line (string trim $line)
        if test -z "$line"
            continue
        end
        if string match -q -r '^#' -- $line
            continue
        end
        set key_val (string split -m 1 '=' -- $line)
        if test (count $key_val) -lt 2
            continue
        end
        set key $key_val[1]
        set value $key_val[2]
        set -gx $key $value
    end <~/.env
end

function fish_user_key_bindings
    if test "$__fish_active_key_bindings" = fish_vi_key_bindings
        bind --mode insert --sets-mode default jj repaint
    end
end

set -g fish_key_bindings fish_vi_key_bindings
set -g fish_sequence_key_delay_ms 200

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

function fish_user_key_bindings
    # ノーマル(=command)モード: yy / Y で行コピーをクリップボードへ
    bind -M default yy fish_clipboard_copy
    bind -M default Y fish_clipboard_copy

    # ビジュアルモード: 選択範囲を y でクリップボードへ
    bind -M visual y fish_clipboard_copy

    # ノーマル(=command)モード: p でクリップボードから貼り付け
    bind -M default p fish_clipboard_paste

    bind -M insert -m default jj cancel repaint-mode
end

fish_add_path /opt/nvim-linux-x86_64/bin

## alias
abbr ch sudo chown ke-koizumi -R .
abbr chm sudo chmod 777 -R .
abbr rbd 'git fetch origin develop && git rebase origin/develop'
abbr g-skip  "git update-index --skip-worktree"
abbr g-unskip "git update-index --no-skip-worktree"
abbr g-skip-ls "git ls-files -v | grep '^S' | cut -c3-"
abbr rmzone 'find . -type f -name "*Zone.Identifier" -delete'


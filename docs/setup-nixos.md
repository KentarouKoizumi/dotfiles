# NixOS（T2） 向け初期設定

Nix は導入済みなので、追加インストールは不要。NixOS 本体とは独立した Home Manager を設定する。

## clone と環境パラメータ

```bash
git clone https://github.com/KentarouKoizumi/dotfiles.git
cd dotfiles
cp -n src/.config/home-manager/params.example.nix src/.config/home-manager/params.nix
${EDITOR:-vi} src/.config/home-manager/params.nix
```

`username`・`homeDirectory`・`system` をこの環境に合わせる（確認例: `id -un`、`echo "$HOME"`、`uname -m`）。
`system` は Intel/AMD 64bit なら `x86_64-linux`、ARM 64bit なら `aarch64-linux`。
既存の clone では `git clone` を省き、そのリポジトリに移動する。既存の `params.nix` は上書きしない。

`params.nix` は Git 管理対象外。次の `path:` 指定でローカル設定も flake に含める。
Nix ストアにコピーされるため、秘密情報は書かない。

## ビルドと反映

```bash
nix --extra-experimental-features 'nix-command flakes' build --no-update-lock-file "path:$PWD/src/.config/home-manager#homeConfigurations.nixos-t2.activationPackage" && \
bash script.sh && \
HOME_MANAGER_BACKUP_EXT=backup ./result/activate
```

WSL 専用設定は含まない。

ビルド成功後に設定ファイルのリンク作成・反映を行う。既存の設定はバックアップされる。
ターミナルを再起動して fish が起動したら、初回のみ `tide configure` を実行する。

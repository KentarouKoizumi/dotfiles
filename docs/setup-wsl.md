# WSL 向け初期設定

## Nix の準備

Nix 未導入ならインストールする。最新手順は [公式インストーラー](https://github.com/NixOS/nix-installer) を参照。

```bash
curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes
```

ターミナルを再起動して `nix --version` を確認する。

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
nix --extra-experimental-features 'nix-command flakes' build --no-update-lock-file "path:$PWD/src/.config/home-manager#homeConfigurations.wsl.activationPackage" && \
bash script.sh && \
HOME_MANAGER_BACKUP_EXT=backup ./result/activate
```

WSL 用のパッケージ・fish 略語を含む。

ビルド成功後に設定ファイルのリンク作成・反映を行う。既存の設定はバックアップされる。
ターミナルを再起動して fish が起動したら、初回のみ `tide configure` を実行する。

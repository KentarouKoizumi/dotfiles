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
${EDITOR:-vi} src/.config/home-manager/params.nix
```

`environment = "wsl";` に設定し、`username`・`homeDirectory`・`system` をこの環境に合わせる（確認例: `id -un`、`echo "$HOME"`、`uname -m`）。
`system` は Intel/AMD 64bit なら `x86_64-linux`、ARM 64bit なら `aarch64-linux`。
既存の clone では `git clone` を省き、そのリポジトリに移動する。設定済みの値は引き継ぐ。

`params.nix` は汎用のサンプル値を Git 管理している。各環境で編集した値はコミットしない。
Nix ストアにコピーされるため、秘密情報は書かない。

## ビルドと反映

```bash
nix --extra-experimental-features 'nix-command flakes' build --no-update-lock-file './src/.config/home-manager#homeConfigurations.wsl.activationPackage' && \
bash script.sh && \
HOME_MANAGER_BACKUP_EXT=backup ./result/activate
```

WSL 用のパッケージ・fish 略語を含む。

ビルド成功後に設定ファイルのリンク作成・反映を行う。既存の設定はバックアップされる。
ターミナルを再起動して fish が起動したら、初回のみ `tide configure` を実行する。

## 設定変更の反映

`script.sh` が `~/.config/home-manager` へリンクを作るので、以降は任意のディレクトリで実行できる。
ユーザー名から設定を自動選択し、`params.nix` の `environment` を使う。

```bash
home-manager switch
```

Nix の `nix-command`・`flakes` は常時有効にしておく（初回ビルドのフラグはその実行時のみ有効）。

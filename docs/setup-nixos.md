# NixOS（T2） 向け初期設定

Nix は導入済みなので、追加インストールは不要。NixOS 本体とは独立した Home Manager を設定する。
Nix の `nix-command`・`flakes` を有効にしておく。

## clone と環境パラメータ

```bash
git clone https://github.com/KentarouKoizumi/dotfiles.git
cd dotfiles
${EDITOR:-vi} src/.config/home-manager/params.nix
```

`environment = "nixos-t2";` に設定し、`username`・`homeDirectory`・`system` をこの環境に合わせる（確認例: `id -un`、`echo "$HOME"`、`uname -m`）。
`system` は Intel/AMD 64bit なら `x86_64-linux`、ARM 64bit なら `aarch64-linux`。
既存の clone では `git clone` を省き、そのリポジトリに移動する。設定済みの値は引き継ぐ。

`params.nix` は汎用のサンプル値を Git 管理している。各環境で編集した値はコミットしない。
Nix ストアにコピーされるため、秘密情報は書かない。

## 初回の反映

```bash
bash script.sh && \
nix run github:nix-community/home-manager -- switch -b backup
```

WSL 専用設定は含まない。

設定ファイルのリンクを作成してから、Home Manager がビルド・反映をまとめて行う。既存の設定はバックアップされる。
ターミナルを再起動して fish が起動したら、初回のみ `tide configure` を実行する。

## 設定変更の反映

`script.sh` が `~/.config/home-manager` へリンクを作るので、以降は任意のディレクトリで実行できる。
ユーザー名から設定を自動選択し、`params.nix` の `environment` を使う。

```bash
home-manager switch
```

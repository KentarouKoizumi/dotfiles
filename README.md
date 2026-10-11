# 俺専用Dotfiles

## 初期設定

NixOS は Nix が導入済みなので、次のインストール手順は不要。WSL など Nix 未導入の環境のみ実行（都度ドキュメント等を参照することを推奨します）。
参考: https://github.com/NixOS/nix-installer
```bash
curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes
```

terminal再起動してnixインストール確認
```bash
nix --version
```

リポジトリのルートで、ロック済みの flake をビルドし、成功後に設定ファイルのリンクを作成して反映する。
NixOS（T2）では WSL 設定を含まない `ke-koizumi@nixos-t2` を指定する。

```bash
nix --extra-experimental-features 'nix-command flakes' build --no-update-lock-file './src/.config/home-manager#homeConfigurations."ke-koizumi@nixos-t2".activationPackage' && \
bash script.sh && \
HOME_MANAGER_BACKUP_EXT=backup ./result/activate
```

WSL では同じコマンドの `ke-koizumi@nixos-t2` を `ke-koizumi` に置き換える。
LSP・oxfmt は共通の `lsp.nix` で管理するため、Mason でのインストールは不要。

terminal再起してfishが立ち上がることを確認し、tideの初期設定

```fish
tide configure
```


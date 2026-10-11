# 俺専用Dotfiles

## 初期設定

- [WSL 向け手順](docs/setup-wsl.md)
- [NixOS（T2）向け手順](docs/setup-nixos.md)

ユーザー名・ホームディレクトリ・アーキテクチャ・環境は clone 後に各環境の `params.nix` で設定する。
LSP・oxfmt は共通の `lsp.nix` で管理するため、Mason でのインストールは不要。

初期設定後の反映は `home-manager switch`。`script.sh` のリンクから設定を自動検出する。

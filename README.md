# 俺専用Dotfiles

## 初期設定

- [WSL 向け手順](docs/setup-wsl.md)
- [NixOS（T2）向け手順](docs/setup-nixos.md)

ユーザー名・ホームディレクトリ・アーキテクチャは clone 後に各環境の `params.nix` で設定する。
LSP・oxfmt は共通の `lsp.nix` で管理するため、Mason でのインストールは不要。

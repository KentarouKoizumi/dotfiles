# 俺専用Dotfiles

## 初期設定

各種設定ファイルのシンボリックリンクを作成
```bash
bash script.sh
```

nixのインストール（都度ドキュメント等を参照することを推奨します。）
参考: https://github.com/NixOS/nix-installer
```bash
curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes
```

terminal再起動してnixインストール確認
```bash
nix --version
```

home-manageで環境構築（シンボリックリンクで、正しい位置にflakesの設定ファイルが配置されているのでディレクトリ指定は不要）
```bash
nix run home-manager/master -- switch -b backup
```

terminal再起してfishが立ち上がることを確認し、tideの初期設定

```fish
tide configure
```


{ pkgs, ... }:

{
  home.packages = with pkgs; [
    inotify-tools
  ];

  programs.fish.shellAbbrs = {
    rmzone = "find . -type f -name \"*Zone.Identifier\" -delete -print";
    exp = "explorer.exe .";
  };
}

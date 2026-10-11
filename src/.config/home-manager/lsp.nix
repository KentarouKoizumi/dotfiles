{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lua-language-server
    pyright
    typescript-language-server
    tailwindcss-language-server
    csharp-ls
    docker-compose-language-service
    oxlint
    terraform-ls
    tflint
    oxfmt
  ];
}

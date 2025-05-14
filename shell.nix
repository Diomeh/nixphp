{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    nodejs_22
    ngrok
    sqlite
    php82Packages.composer
    heroku
    redis
    (php82.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [ xdebug ]));
      extraConfig = ''
        xdebug.mode=debug
        xdebug.idekey=PHPSTORM
      '';
    })
  ];
}

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    nodejs_24
    ngrok
    sqlite
    php84Packages.composer
    heroku
    redis
    postman
    jq
    dbeaver-bin
    awscli2
    (php.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [ xdebug ]));
      extraConfig = ''
        xdebug.mode=debug
        xdebug.idekey=PHPSTORM
      '';
    })
  ];
}

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    nodejs_22
    ngrok
    php82Packages.composer
    (php82.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [ xdebug ]));
      extraConfig = ''
        xdebug.mode=debug
        xdebug.idekey=PHPSTORM
      '';
    })
  ];
}

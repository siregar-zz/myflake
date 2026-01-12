{ config, pkgs, ... }:

let
  rubyEnv = pkgs.bundlerEnv {
    name = "smashing-env";
    ruby = pkgs.ruby;
    gemdir = ./.;
  };
in

{
  environment.systemPackages = with pkgs; [
    nagios
    nodejs
    yarn
    ruby
    bundler
    rubyEnv
  ];

  # Web server untuk dashboard
  services.caddy = {
    enable = true;
    virtualHosts."localhost:8080" = {
      extraConfig = ''
        reverse_proxy localhost:3000
      '';
    };
  };

  # Nagios monitoring service
  services.nagios = {
    enable = true;
    objectDefs = [];
  };

  # Install smashing gem ke environment
  environment.shellInit = ''
    export GEM_HOME=${rubyEnv}/${pkgs.ruby.gemPath}
    export PATH=${rubyEnv}/bin:$PATH
  '';
}

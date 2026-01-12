{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nagios
    nodejs
    yarn
    ruby
    bundler
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
}


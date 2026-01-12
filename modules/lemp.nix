{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    php
    php82Packages.composer
  ];

  services.nginx = {
    enable = true;
    virtualHosts."localhost" = {
      locations."/" = {
        root = "/var/www/html";
        extraConfig = ''
          index index.php index.html index.htm;
          try_files $uri $uri/ /index.php?$query_string;
        '';
      };
      locations."~ \.php$" = {
        extraConfig = ''
          fastcgi_pass unix:${config.services.phpfpm.pools.www.socket};
          fastcgi_index index.php;
          include ${pkgs.nginx}/conf/fastcgi_params;
        '';
      };
    };
  };

  services.phpfpm.pools.www = {
    user = "nginx";
    settings = {
      "listen" = config.services.phpfpm.pools.www.socket;
      "listen.owner" = "nginx";
      "listen.group" = "nginx";
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 4;
      "pm.max_requests" = 500;
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mysql80;
  };
}

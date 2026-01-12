{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    elasticsearch
    logstash
    kibana
    beats
  ];

  services.elasticsearch = {
    enable = true;
    extraConf = ''
      cluster.name = elk-cluster
      node.name = ${config.networking.hostName}
      network.host = 0.0.0.0
      discovery.type = single-node
      xpack.security.enabled = false
    '';
  };

  services.logstash = {
    enable = true;
    inputConfig = ''
      tcp {
        port => 5000
        codec => json
      }
    '';
    filterConfig = ''
      if [type] == "syslog" {
        grok {
          match => { "message" => "%{SYSLOGLINE}" }
        }
      }
    '';
    outputConfig = ''
      elasticsearch {
        hosts => ["localhost:9200"]
        index => "logstash-%{+YYYY.MM.dd}"
      }
    '';
  };

  services.kibana = {
    enable = true;
    extraConf = {
      server.host = "0.0.0.0";
      server.port = 5601;
      elasticsearch.hosts = [ "http://localhost:9200" ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 5000 5601 9200 9300 ];
}

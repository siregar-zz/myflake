{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    elasticsearch
    logstash
  ];

  services.elasticsearch = {
    enable = true;
    extraConf = ''
      cluster.name = elk-cluster
      node.name = ${config.networking.hostName}
      network.host = 0.0.0.0
      discovery.type = single-node
    '';
  };

  services.logstash = {
    enable = true;
    inputConfig = ''
      tcp {
        port => 5000
        codec => json
      }
      stdin {
        codec => json
      }
    '';
    outputConfig = ''
      elasticsearch {
        hosts => ["localhost:9200"]
        index => "logstash-%{+YYYY.MM.dd}"
      }
      stdout { codec => rubydebug }
    '';
  };

  networking.firewall.allowedTCPPorts = [ 5000 5601 9200 9300 ];

  # Kibana bisa dijalankan manual: kibana --elasticsearch.hosts http://localhost:9200
}


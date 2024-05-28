{ pkgs, ... }: {
  # Enable common container config files in /etc/containers
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    # docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev
  ];

  # Containers via systemd
  virtualisation.oci-containers = {
    backend = "podman";
    containerOptions.login = {
      username = "qeden";
      password = /home/quinn/.quay_login;
      registry = "https://quay.io";
    }

    containers = {
      centos-bootc = {
        image = "quay.io/centos-bootc/centos-bootc";
        autoStart = true;
        ports = [ "127.0.0.1:2222:2222" ];
      };
    };
  };

  home.file.".quay_login".text = ''
  Qboyy$1215
  '';
}
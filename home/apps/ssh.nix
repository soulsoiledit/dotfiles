{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "aliases" ];
    settings."*" = {
      addKeysToAgent = "2h";
      hashKnownHosts = true;
      serverAliveInterval = 15;
    };
  };

  services.ssh-agent.enable = true;
}

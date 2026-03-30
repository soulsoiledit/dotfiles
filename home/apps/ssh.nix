{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "aliases" ];
    matchBlocks."*" = {
      addKeysToAgent = "1h";
      hashKnownHosts = true;
      serverAliveInterval = 15;
    };
  };

  services.ssh-agent.enable = true;
}

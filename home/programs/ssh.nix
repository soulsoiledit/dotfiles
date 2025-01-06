{
  programs.ssh = {
    enable = true;
    includes = [ "aliases" ];
    forwardAgent = true;
    addKeysToAgent = "1h";
    hashKnownHosts = true;
  };

  services.ssh-agent.enable = true;
}

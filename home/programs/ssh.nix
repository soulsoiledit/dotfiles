{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "confirm";
    hashKnownHosts = true;
  };

  services.ssh-agent.enable = true;
}

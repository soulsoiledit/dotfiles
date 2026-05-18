{
  services.pipewire = {
    enable = true;
    wireplumber = {
      enable = true;
      configs = {
        "limit-tears-volume" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  "node.name" = "alsa_output.usb-YUANDAO_Technology_Tears_DSP_3302129E250916-00.analog-stereo";
                }
              ];
              actions = {
                update-props = {
                  "channelmix.max-volume" = 0.40;
                };
              };
            }
          ];
        };
      };
    };
  };
}

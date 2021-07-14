{
  programs.htop = {
    enable = true;
    settings = {
      tree_view = true;
      header_margin = false;
      cpu_count_from_zero = true;
      shadow_other_users = true;
      show_program_path = false;
      highlight_base_name = true;
      highlight_threads = false;

      hide_threads = true;
      hide_kernel_threads = true;
      hide_userland_threads = true;

      # PID M_RESIDENT PERCENT_MEM PERCENT_CPU TIME COMM
      fields = [ 0 39 47 46 49 1 ];

      left_meters = [ "LeftCPUs2" "Memory" "Swap" ];
      left_meter_modes = [ 1 1 1 ];
      right_meters = [ "RightCPUs2" "Tasks" "Uptime" ];
      right_meter_modes = [ 1 2 2 ];
    };
  };
}

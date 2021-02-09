{
  programs.htop = {
    enable = true;
    treeView = true;
    headerMargin = false;
    cpuCountFromZero = true;
    shadowOtherUsers = true;
    showProgramPath = false;

    highlightBaseName = true;
    highlightThreads = false;

    hideThreads = true;
    hideKernelThreads = true;
    hideUserlandThreads = true;

    sortKey = "M_RESIDENT";
    fields = [ "PID" "M_RESIDENT" "PERCENT_MEM" "PERCENT_CPU" "TIME" "COMM" ];

    meters = {
      left = [
        "LeftCPUs2"
        "Memory"
        "Swap"
      ];
      right = [
        "RightCPUs2"
        "Tasks"
        "Uptime"
      ];
    };
  };
}

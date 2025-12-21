{...}:
{

  powerManagement.enable = true;

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.tlp.settings = {
    # Battery charge thresholds
    START_CHARGE_THRESH_BAT0 = 40;
    STOP_CHARGE_THRESH_BAT0 = 80;

    # AC settings
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    PLATFORM_PROFILE_ON_AC = "performance";
    CPU_BOOST_ON_AC = 1;
    DISK_APM_LEVEL_ON_AC = "254";
    PCIE_ASPM_ON_AC = "performance";

    # Battery settings
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    PLATFORM_PROFILE_ON_BAT = "low-power";
    CPU_BOOST_ON_BAT = 0;
    DISK_APM_LEVEL_ON_BAT = "128";
    PCIE_ASPM_ON_BAT = "powersave";
  };
}
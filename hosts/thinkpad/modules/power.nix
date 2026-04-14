{...}:
{
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.tlp.settings = {
    enable = true;
    # Battery charge thresholds (unchanged, good)
    START_CHARGE_THRESH_BAT0 = 40;
    STOP_CHARGE_THRESH_BAT0 = 80;

    # Battery: aggressive power save
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    PLATFORM_PROFILE_ON_BAT = "low-power";
    CPU_BOOST_ON_BAT = 0;
    CPU_SCALING_MAX_FREQ_ON_BAT = "2500000";  # 2.5GHz cap (55% of 4.5GHz max); use 2000000 for ultra-saving
    CPU_SCALING_MIN_FREQ_ON_BAT = "0";  # Allow lowest possible
    DISK_APM_LEVEL_ON_BAT = "1";
    PCIE_ASPM_ON_BAT = "powersupersave";
    SATA_LINKPWR_ON_BAT = "min_power";

    # Extras for max savings on T14 AMD
    WIFI_PWR_ON_BAT = "on";
    USB_AUTOSUSPEND = 1;
    SOUND_POWER_SAVE_ON_BAT = 1;
    RUNTIME_PM_ON_BAT = "auto";
    DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";  # Optional: disable if unused

    # AC: performance (unchanged)
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    PLATFORM_PROFILE_ON_AC = "performance";
    CPU_BOOST_ON_AC = 1;
    CPU_SCALING_MAX_FREQ_ON_AC = "0";  # Uncapped
    DISK_APM_LEVEL_ON_AC = "254";
    PCIE_ASPM_ON_AC = "performance";
    SATA_LINKPWR_ON_AC = "max_performance";
 };
}
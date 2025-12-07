{...}:
{
  programs.plasma.powerdevil = {

    batteryLevels.lowLevel = 30;
    batteryLevels.criticalLevel = 10;
    batteryLevels.criticalAction = "hibernate";

    AC = {
      dimDisplay = {
        enable = true;
        idleTimeout = 600;
      };
      powerProfile =  "performance";
      displayBrightness = 100;
      powerButtonAction = "sleep";
      autoSuspend.action = "sleep";
      autoSuspend.idleTimeout =   600;
      whenLaptopLidClosed = "sleep";
      whenSleepingEnter = "hybridSleep";
    };
    
    battery = {
      powerProfile = "powerSaving";
      dimDisplay = {
        enable = true;
        idleTimeout = 180;
      };
      autoSuspend = {
        action = "sleep";
        idleTimeout = 300;
      };
      displayBrightness = 70;
      powerButtonAction = "hibernate";
      whenSleepingEnter = "standbyThenHibernate";
      whenLaptopLidClosed = "hibernate";
    };

    lowBattery = {
      powerProfile = "powerSaving";
      dimDisplay = {
        enable = true;
        idleTimeout = 60;
      };
      autoSuspend = {
        action = "sleep";
        idleTimeout = 120;
      };
      displayBrightness = 60;
      powerButtonAction = "hibernate";
      whenSleepingEnter = "standbyThenHibernate";
      whenLaptopLidClosed = "hibernate";
    };
  };
}
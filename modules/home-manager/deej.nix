{deej, ...}:
{
  services.deej = {
    enable = true;  # Required: enables the deej service
    useDevBuild = true;   # 
    
    sliderMapping = {  # Maps slider numbers to applications or "master"/"mic"
      "0" = "master";
      "1" = "deej.unmapped";    #essentially most games
      "2" = [ "firefox" ];
      "3" = [ "Chromium" "electron" ];  # feishin, music player
      "4" = [ "WEBRTC VoiceEngine" ".Discord-wrapped" ];
      "5" = "mic";
    };
    
    invertSliders = false;  # Whether to invert slider values (true/false)
    
    serialPort = "/dev/ttyUSB0";  # Serial port for the deej device
    
    baudRate = 921600;  # Baud rate for serial communication (integer)
    
    noiseReduction = 0.015;  # Noise reduction value (float)
    
    verbose = true;  # Enable verbose logging (true/false)
  };
}
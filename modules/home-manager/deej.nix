{deej, ...}:
{
  services.deej = {
    enable = true;  # Required: enables the deej service
    
    sliderMapping = {  # Maps slider numbers to applications or "master"/"mic"
      "0" = "master";  # Master volume
      "1" = [ "firefox" ];  # Single app
      "2" = "deej.unmapped";  # Unmapped slider
      "3" = [ "Chromium" "electron" ];  # Multiple apps
      "4" = [ "WEBRTC VoiceEngine" ".Discord-wrapped" ];
      "5" = "mic";  # Microphone
    };
    
    invertSliders = false;  # Whether to invert slider values (true/false)
    
    serialPort = "/dev/ttyUSB0";  # Serial port for the deej device
    
    baudRate = 9600;  # Baud rate for serial communication (integer)
    
    noiseReduction = 0.025;  # Noise reduction value (float)
    
    verbose = true;  # Enable verbose logging (true/false)
  };
}
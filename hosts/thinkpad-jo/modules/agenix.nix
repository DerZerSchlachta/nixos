{ inputs, ... }:
{
  environment.systemPackages = [
    inputs.agenix.packages.x86_64-linux.default
  ];
  
  age.secrets.airvpn-key = {
    file = ../../../secrets/thinkpad-jo/airvpn-key.age;
    mode = "600";
  };

  age.secrets.airvpn-psk = {
    file = ../../../secrets/thinkpad-jo/airvpn-psk.age;
    mode = "600";
  };
  
}
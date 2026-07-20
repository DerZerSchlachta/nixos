{ ... }:
{
  age.secrets.airvpn-key = {
    file = ../../../secrets/desktop-hannover/airvpn-key.age;
    mode = "600";
  };

  age.secrets.airvpn-psk = {
    file = ../../../secrets/desktop-hannover/airvpn-psk.age;
    mode = "600";
  };
}
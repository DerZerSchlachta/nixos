{ ... }:
{
  age.secrets.airvpn-key = {
    file = ../../../secrets/desktop-jo/airvpn-key.age;
    mode = "600";
  };

  age.secrets.airvpn-psk = {
    file = ../../../secrets/desktop-jo/airvpn-psk.age;
    mode = "600";
  };

  age.secrets.smb_server_pw = {
    file = ../../../secrets/smb_server_pw.age;
    mode = "600";
  };
}
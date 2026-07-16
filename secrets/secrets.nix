let
  johannes = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXNpatNI4yUVpKEBdjYs7nd4Q/hWK32YQuQkaeXWv7h johannes.bartschies@gmail.com";
  desktop-jo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEPIoJ7xTULsK9o1u1FskRHQpgDcmfD8tdbyPtkrRru root@desktop-jo";
in
{
  "airvpn-key.age".publicKeys = [ desktop-jo johannes ];
  "airvpn-psk.age".publicKeys = [ desktop-jo johannes ];
}

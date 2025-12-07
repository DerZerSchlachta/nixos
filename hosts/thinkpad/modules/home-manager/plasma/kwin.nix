{ ... }:
{
  programs.plasma.kwin = {
    virtualDesktops.names = [
      "Main"
      "Gaming"
      "VMWare"
    ];
    virtualDesktops.rows = 1;
  };
}

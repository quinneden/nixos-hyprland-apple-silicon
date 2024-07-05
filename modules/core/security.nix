{ ... }: 
{
  security.polkit.enable = true;
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
}

{ inputs, nixpkgs, self, username, host, ...}:
{
  imports =
       [ (import ./hardware.nix) ]
    ++ [ (import ./xserver.nix) ]
    ++ [ (import ./network.nix) ]
    ++ [ (import ./sound.nix) ]
    ++ [ (import ./program.nix) ]
    ++ [ (import ./security.nix) ]
    ++ [ (import ./services.nix) ]
    ++ [ (import ./system.nix) ]
    ++ [ (import ./user.nix) ]
    # ++ [ (import ./virtualization.nix) ]
    ++ [ (import ./wayland.nix) ];
}

{
  description = "Qeden's NixOS System Flake";

  inputs = {
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    
    catppuccin-cava = {
      url = "github:catppuccin/cava";
      flake = false;
    };
    
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url =  "git+https://github.com/hyprwm/Hyprland?submodules=1";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hypr-contrib = {
      url = "github:hyprwm/contrib";
    };
    
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
    };

  	nixos-apple-silicon = {
  	  url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
  	};

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  
    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs = { nixpkgs, nixos-apple-silicon, hyprland, self, ...} @ inputs:
  let
    username = "quinn";
    system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      # overlays = with inputs; [ nixos-apple-silicon.overlays.apple-silicon-overlay ];
    };
    lib = nixpkgs.lib;
  in
  {
    # overlays.default = selfPkgs.overlay;
    nixosConfigurations = {
      main = lib.nixosSystem {
        inherit system;
        modules = [ (import ./modules/core.nix) ];
        specialArgs = { host="main"; inherit self inputs username; };
      };
    };
  };
}

{
    description = "Template";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland = {
            type = "git";
            url = "https://github.com/hyprwm/Hyprland";
            ref = "refs/tags/v0.43.0";
            submodules = true;
        };

        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs: {
        nixosConfigurations.minimal = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs;};
            modules = [
                ./configuration.nix
                ./hyprland.nix
                inputs.home-manager.nixosModules.home-manager
                inputs.disko.nixosModules.disko
                {
                    home-manager.users.nixos.imports = [
                        ./home.nix
                        inputs.hyprland.homeManagerModules.default
                    ];
                }
            ];
        };
    };
}

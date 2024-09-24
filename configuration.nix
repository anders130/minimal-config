{pkgs, ...}: {
    imports = [
        ./hardware-configuration.nix
        ./disk-config.nix
    ];

    system.stateVersion = "24.05";

    networking = {
        hostName = "nixos-minimal";
        networkmanager.enable = true;
    };

    services.openssh.enable = true;

    users.users.nixos = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
    };

    nix.settings = {
        experimental-features = [
            "nix-command"
            "flakes"
        ];

        trusted-users = ["nixos"];
    };

    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.firewall.enable = true;

    services.xserver = {
        enable = true;

        xkb = {
            layout = "us";
            variant = "";
        };
    };

    time.timeZone = "Europe/Berlin";

    # console keyboard layout
    console.keyMap = "us";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
    };
}

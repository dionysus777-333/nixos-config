# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, host, conftype, ui, arch, ... }:
let
  server = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    htop
    ffmpeg
    git
    gh
    unzip
    unrar
    xclip
    tree
    nix-tree
    bc
    kdePackages.kleopatra
    jq
    nix-prefetch-github
  ];
  minimal = server ++ (with pkgs;
  [
    ghostty
    librewolf
    alsa-utils
    btop
    fastfetch
    scrot
    keyutils
    qimgv
    rofi
    emacs
    evtest
    lact
    yazi
    zathura
  ]);
  extra = minimal ++ (with pkgs; 
  [
    electrum 
    feather
    kdePackages.kiten
    anki
    spotify-player
    mullvad-vpn
    libreoffice
    obs-studio
  ]);
in
{
  imports = [ ./hardware-configuration.nix ];


  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Plymouth
  boot.plymouth = {
    enable = true;
    theme = lib.mkForce "bgrt";
    font = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFont-Regular.ttf";
  };

  console = {
    packages = [ pkgs.terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";
    colors = [
    "000000" "ff6c60" "a8ff60" "ffffb6"
    "96cbfe" "ff73fd" "c6c5fe" "fdfbee"
    "000000" "e9c062" "242422" "484844"
    "6c6c66" "b18a3d" "918f88" "b5b3aa"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /mnt 0755 root root -"
    "d /mnt/usb 0755 root root -"
  ];

  services.mullvad-vpn.enable = true;
    # services.resolved = {
    # enable = true;
    # };

  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [ "quiet" "splash" "udev.log_level=3" "systemd.show_status=auto" ];
  boot.loader.timeout = 0;
  boot.loader.systemd-boot.consoleMode = "max";

  networking.hostName = host; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

 

  programs.dconf.profiles.user.databases = [{
   settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  }];

  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
  };
  
  i18n.inputMethod = {
  type = "fcitx5";
  enable = lib.mkIf (conftype != "S") true;
  fcitx5.addons = with pkgs; [
    fcitx5-mozc
    fcitx5-gtk
    ];
  };
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  services.xserver.displayManager.sessionCommands = 
    if ui == "D" then 
      ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --mode 2560x1440 --rate 165
      ''
    else 
      ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --rate 60
      '';

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Configure keymap in X11
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    dpi = 96;
      # if ui == "L" then 144
      # else 96;
    windowManager.qtile = {
       enable = lib.mkIf (conftype != "S") true;
       };
    xkb = {
       layout = "us";
       variant = "";
       };
  };
  services.displayManager.ly.enable = lib.mkIf (conftype != "S") true;
  xdg.portal.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = 
    if conftype == "E" then extra
    else if conftype == "M" then minimal
    else if conftype == "S" then server
    else server;

  programs.zsh = {
  enable = true;
  };

  programs.steam = {
    enable = lib.mkIf (conftype == "E") true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    remotePlay.openFirewall = false;
  };
  programs.gamemode.enable = lib.mkIf (conftype == "E") true;

  hardware.graphics.enable32Bit = true;

  # Virtualbox
  virtualisation.virtualbox.host.enable = lib.mkIf (conftype == "E") true;
  users.extraGroups.vboxusers.members = [ "user" ];


  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    packages = [
    "com.github.vikdevelop.photopea_app"
    ]
    ++ lib.optionals (conftype == "E")
    [
    "org.equicord.equibop"
    ];
  };
  
  # Locking
  programs.i3lock.enable = true;

  # Disable Mouse Acceleration
  
  services.xserver.libinput = {
    enable = true;
    mouse = {
      # Use the "flat" profile to disable acceleration
      accelProfile = "flat";
      # Optional: set base sensitivity (0 is default, -1.0 to 1.0 range)
      accelSpeed = "0"; 
      };
    };

  


  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}

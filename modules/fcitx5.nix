{ pkgs, config, inputs, ... }:
{
  i18n.inputMethod.fcitx5.settings.inputMethod = {
    GroupOrder."0" = "Default";
    "Groups/0" = {
      Name = "Default";
      "Default Layout" = "us";
      DefaultIM = "mozc";
    };
    "Groups/0/Items/0".Name = "keyboard-us";
    "Groups/0/Items/1".Name = "mozc";
  };
  # i18n.inputMethod.fcitx5.settings.globalOptions = { };
  
  # Local config at ~/.config/fcitx5 needs to be ignored using the following option.
  i18n.inputMethod.fcitx5.ignoreUserConfig = true;
}

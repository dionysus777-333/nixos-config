{ pkgs, inputs, ... }:
{
 programs.keepassxc.settings = {
    # GUI
    ApplicationTheme = "dark";

    # Security
    Security_LockDatabaseIdleSeconds = 30;
  };
}

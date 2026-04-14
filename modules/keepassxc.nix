{ pkgs, inputs, ... }:
{
 programs.keepassxc = {
  enable = true;
  settings = {
   GUI = {
    ApplicationTheme = "dark";
   };
   Security = {
    LockDatabaseIdleSeconds = 30;
   };
  };
 };
}

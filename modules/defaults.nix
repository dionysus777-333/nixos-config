{ pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
    };
  };
  
  # Optional: Set the BROWSER environment variable
  home.sessionVariables = {
    BROWSER = "librewolf";
  };
}

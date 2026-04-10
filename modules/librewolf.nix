{ pkgs, ... }: {
  programs.librewolf = {
    enable = true;
    # Enable WebGL, cookies and history
    settings = {
      "browser.tabs.tabmanager.enabled" = false;
      "browser.discovery.containers.enabled" = false;
      "layout.spellcheckDefault" = 0;
      "media.videocontrols.picture-in-picture.enabled" = false;
      "browser.search.defaultenginename" = "Startpage";
      "browser.sessionstore.resume_from_crash" = false;
      "browser.tabs.groups.enabled" = false;
    };
  };
}

{ pkgs, inputs, config, ... }:
{
  programs.firefox = 
  {
    enable = true;
    profiles.default = {
      search = {
       force = true;
       default = "Startpage";
       order = [ "Startpage" "Jisho" "Nix Packages" "NixOS Wiki" ];
       engines = {
         "Startpage" = {
           urls = [{
             template = "https://www.startpage.com/sp/search";
             params = [
               { name = "query"; value = "{searchTerms}"; }
             ];
           }];
           iconUpdateURL = "https://www.startpage.com/favicon.ico";
           definedAliases = [ "@sp" ];
         };
         "Jisho" = {
           urls = [{
             template = "https://jisho.org/search/{searchTerms}";
           }];
           iconUpdateURL = "https://jisho.org/favicon.ico";
           updateInterval = 24 * 60 * 60 * 1000; # every day
           definedAliases = [ "@j" ]; # Typing "@j word" in address bar searches Jisho
         };
         "Nix Packages" = {
           urls = [{
             template = "https://search.nixos.org/packages";
             params = [
               { name = "type"; value = "packages"; }
               { name = "query"; value = "{searchTerms}"; }
             ];
           }];
           iconUpdateURL = "https://nixos.org/favicon.png";
           updateInterval = 24 * 60 * 60 * 1000; # every day
           definedAliases = [ "@np" ];
         };
         "NixOS Wiki" = {
           urls = [{
             template = "https://wiki.nixos.org/w/index.php";
             params = [
               { name = "search"; value = "{searchTerms}"; }
             ];
           }];
           iconUpdateURL = "https://wiki.nixos.org/favicon.ico";
           updateInterval = 24 * 60 * 60 * 1000;
           definedAliases = [ "@nw" ];
         };
         # To disable the default ones you don't like
         "Bing".metaData.hidden = true;
       };
      };
      bookmarks = [
        {
         name = "Toolbar";
         toolbar = true;
         bookmarks = [
           {
             name = "Mokuro";
             tags = [ "mok" ];
             url = "https://reader.mokuro.app";
           }
           {
             name = "Mokuro Catalogue";
             tags = [ "MoCat" ];
             url = "https://mokuro.moe/catalog/";
           }
         ];
        }
      ];
      settings = {
       # --- Privacy & Security Settings ---
       "privacy.firstparty.isolate" = true;
       "privacy.resistFingerprinting" = true;
       "privacy.trackingprotection.enabled" = true;
       "privacy.trackingprotection.socialtracking.enabled" = true;
       "privacy.partition.network_state" = true;
       
       # --- Disable Telemetry & Features ---
       "toolkit.telemetry.enabled" = false;
       "toolkit.telemetry.unified" = false;
       "toolkit.telemetry.archive.enabled" = false;
       "datareporting.healthreport.uploadEnabled" = false;
       "app.shield.optoutstudies.enabled" = false;
       "media.navigator.enabled" = false;
       
       # --- Network Security ---
       "network.prefetch-next" = false;
       "network.dns.disablePrefetch" = true;
       "dom.event.clipboardevents.enabled" = false;
       
       # --- Hardened HTTPS ---
       "dom.security.https_only_mode" = true;
       "dom.security.https_only_mode_ever_enabled" = true;
       
       # --- Make Extensions Work ---
       "extensions.activeLogins" = true;
       "browser.shell.checkDefaultBrowser" = false;
       "extensions.autoDisableScopes" = 0;

       # --- Clear Stuff ---
       "privacy.clearOnShutdown.history" = true;
       "privacy.clearOnShutdown.cookies" = true;
       "privacy.clearOnShutdown.cache" = true;
       "privacy.clearOnShutdown.downloads" = true;
       "privacy.clearOnShutdown.formdata" = true;
       "privacy.clearOnShutdown.sessions" = true;

       "browser.newtabpage.enabled" = false;
       "browser.aboutwelcome.enabled" = false;
       "browser.messaging-system.whatsNewPanel.enabled" = false;
       "browser.startup.homepage_override.mstone" = "ignore";
       "browser.onboarding.enabled" = false;
       "browser.newtabpage.activity-stream.feeds.snippets" = false;
       "browser.startup.homepage" = "about:blank";
      };
            extensions = with inputs.firefox-addons.packages."x86_64-linux";
      [
        ublock-origin
        inputs.firefox-addons.packages."x86_64-linux"."10ten-ja-reader"
      ];
    };
    policies = {
     ExtensionSettings = {
       "uBlock0@raymondhill.net" = {
         installation_mode = "force_installed";
         install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
       };
       "10ten-ja-reader@0x90.org" = {
         installation_mode = "force_installed";
         install_url = "https://addons.mozilla.org/firefox/downloads/latest/10ten-ja-reader/latest.xpi";
       };
     };
     DisableTelemetry = true;
     DisableFirefoxStudies = true;
     DisablePocket = true;
     DisableFormHistory = true;
     # This prevents Firefox from saving ANY history
     
     # Privacy & Tracking
     EnableTrackingProtection = {
       Value = true;
       Locked = true;
       Cryptomining = true;
       Fingerprinting = true;
     };
    };
  };
}

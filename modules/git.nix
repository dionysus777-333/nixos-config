{
  programs.git = {
    enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      credential.helper = "store"; # or libsecret
    };

    aliases = {
      co = "checkout";
      st = "status";
      cm = "commit";
      br = "branch";
    };
  };
}

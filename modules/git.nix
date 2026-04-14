{
  programs.git = {
    enable = true;

    userEmail = "eric.z.dino@outlook.com";
    userName = "dionysus777-333";

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

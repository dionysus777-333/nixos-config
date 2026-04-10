{
  programs.git = {
    enable = true;

    userName = "dionysus777-333";
    userEmail = "eric.z.dino@outlook.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };

    aliases = {
      co = "checkout";
      st = "status";
      cm = "commit";
      br = "branch";
    };
  };
}

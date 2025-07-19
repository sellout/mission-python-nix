{
  config,
  lib,
  ...
}: {
  project = {
    name = "mission-python";
    summary = "A Nix environment for working through “Mission Python”";
  };

  ## dependency management
  services.renovate.enable = true;

  ## development
  programs = {
    direnv.enable = true;
    # This should default by whether there is a .git file/dir (and whether it’s
    # a file (worktree) or dir determines other things – like where hooks
    # are installed.
    git.enable = true;
  };

  ## formatting
  editorconfig.enable = true;
  programs = {
    treefmt.enable = true;
    vale.enable = true;
  };

  ## CI
  services.garnix.enable = true;

  ## publishing
  services = {
    flakehub.enable = true;
    github.enable = true;
  };
}

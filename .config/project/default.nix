{
  config,
  lib,
  ...
}: {
  project = {
    name = "mission-python-nix";
    summary = "A Nix environment for working through “Mission Python”";
  };

  ## dependency management
  services.renovate.enable = true;

  ## development
  programs = {
    direnv.enable = true;
    git = {
      enable = true;
      ignores = [
        ## The directory created when we run `unpackPhase` in the default dev
        ## shell.
        "/source"
      ];
    };
  };

  ## formatting
  editorconfig.enable = true;
  programs = {
    treefmt.enable = true;
    vale.enable = true;
  };

  ## CI
  services.garnix.enable = true;
  services.nix-ci.enable = true;

  ## publishing
  services = {
    flakehub.enable = true;
    github.enable = true;
  };
}

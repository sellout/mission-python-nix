{
  description = "A Nix environment for working through “Mission Python”";

  nixConfig = {
    ## https://github.com/NixOS/rfcs/blob/master/rfcs/0045-deprecate-url-syntax.md
    extra-experimental-features = ["no-url-literals"];
    extra-substituters = ["https://cache.garnix.io"];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
    ## Isolate the build.
    sandbox = "relaxed";
    use-registries = false;
  };

  outputs = {
    flake-utils,
    flaky,
    nixpkgs,
    self,
    systems,
  }: let
    pname = "mission-python";

    supportedSystems = import systems;

    localPackages = pkgs: pypkgs: {
      pgzero = pypkgs.callPackage ./packages/pgzero.nix {};
    };
  in
    {
      schemas = {
        inherit
          (flaky.schemas)
          overlays
          homeConfigurations
          packages
          devShells
          projectConfigurations
          checks
          formatter
          ;
      };

      overlays = {
        default = final: prev: {
          pythonPackagesOverlays =
            (prev.pythonPackagesOverlays or [])
            ++ [
              (self.overlays.python final prev)
            ];

          python3 = let
            self = prev.python3.override {
              inherit self;
              packageOverrides = prev.lib.composeManyExtensions final.pythonPackagesOverlays;
            };
          in
            self;

          python3Packages = final.python3.pkgs;
        };

        python = final: prev: pyfinal: pyprev: {
          inherit (localPackages final pyfinal) pgzero;
        };
      };

      lib = {};

      homeConfigurations = let
        mission-python = self;
      in
        builtins.listToAttrs
        (builtins.map
          (flaky.lib.homeConfigurations.example self
            [
              ({pkgs, ...}: {
                home.packages = [
                  (pkgs.python3.withPackages (pypkgs: [pypkgs.pgzero]))
                ];
                nixpkgs.overlays = [mission-python.overlays.default];
              })
            ])
          supportedSystems);
    }
    // flake-utils.lib.eachSystem supportedSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system}.appendOverlays [
        flaky.overlays.default
      ];

      src = pkgs.lib.cleanSource ./.;
    in {
      packages = localPackages pkgs pkgs.python3Packages;

      projectConfigurations =
        flaky.lib.projectConfigurations.nix {inherit pkgs self;};

      devShells =
        self.projectConfigurations.${system}.devShells
        // {
          default = import ./shell.nix {
            pkgs = pkgs.appendOverlays [self.overlays.default];
          };
        };

      checks = self.projectConfigurations.${system}.checks;
      formatter = self.projectConfigurations.${system}.formatter;
    });

  inputs = {
    ## Flaky should generally be the source of truth for its inputs.
    flaky.url = "github:sellout/flaky";

    flake-utils.follows = "flaky/flake-utils";
    nixpkgs.follows = "flaky/nixpkgs";
    systems.follows = "flaky/systems";
  };
}

{

  # /*****                                                  /******   /****
  # |*    *|  |*   |  |*       ****     **    *****        |*    |  /*    *
  # |*    *|  |*   |  |*      /*       /* *   |*   |      |*    |  |*
  # |*****/   |*   |  |*       ****   /*   *  |*   /     |*    |   ******
  # |         |*   |  |*           |  ******  *****     |*    |         |
  # |         |*   |  |*       *   |  |*   |  |*  *    |*    |   *     |
  # |          ****    *****    ****  |*   |  |*   *   ******    *****
  #
  #  ==========================================================================

  # This is the default PulsarOS on-device server configuration flake.
  # It loads your remote configuration,
  # in conjunction with the PulsarOS default configuration,
  # and builds your system environment.
  # You can change the versions of the inputs to revert
  # to previous system configurations.
  # However, you should keep this flake's lockfile,
  # so you can declaratively restore packages to previous versions if necessary.
  description = "On-device system configuration flake";

  inputs = {
    # PulsarOS uses the latest nixpkgs channel,
    # so new (but somewhat? stable) packages are used by default.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11-small";

    # PulsarOS
    pulsaros.url = "github:quantum9innovation/pulsaros/main";

    # Server configuration
    config.url = "github:arcturusnavigation/atlantic/main";
  };

  outputs =
    {
      nixpkgs,
      pulsaros,
      config,
      ...
    }:
    {
      # Build the system
      nixosConfigurations.atlantic = (pulsaros.make config).system;

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}

{ inputs, lib, ... }:

let
  machineNixpkgsType = lib.types.submodule {
    options = {
      allowUnfreePredicate = lib.mkOption {
          type = lib.types.listOf lib.types.singleLineStr;
          description = "List of allowed unfree packages";
          default = [ ];
      };
    };
  };

  userFilterFunctionType = lib.types.functionTo (lib.types.attrsOf lib.types.attrs);

  machineUsersType = lib.types.submodule {
    options = {
      users = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        description = "User definitions with roles (e.g., 'admin', 'guest')";
        default = { };
      };

      forAll = lib.mkOption {
        type = userFilterFunctionType;
        description = "Apply configuration to all users";
        readOnly = true;
      };

      forAdmins = lib.mkOption {
        type = userFilterFunctionType;
        description = "Apply configuration to admin users only";
        readOnly = true;
      };

      forGuests = lib.mkOption {
        type = userFilterFunctionType;
        description = "Apply configuration to guest users only";
        readOnly = true;
      };
    };
  };

  machineType = lib.types.submodule {
    options = {
      system = lib.mkOption {
        type = lib.types.str;
        description = "System architecture for this machine";
        example = "x86_64-linux";
      };

      profile = lib.mkOption {
        type = lib.types.str;
        description = "Profile type for this machine";
        example = "desktop";
      };

      timeZone = lib.mkOption {
        type = lib.types.str;
        description = "Timezone for this machine";
        default = "UTC";
      };

      domain = lib.mkOption {
        type = lib.types.str;
        description = "Domain for this machine";
        default = "local";
      };

      nixpkgs = lib.mkOption {
        type = machineNixpkgsType;
        default = { };
        description = "Nixpkgs configuration";
      };

      users = lib.mkOption {
        type = machineUsersType;
        default = { };
        description = "User configuration and filter functions";
      };
    };
  };

  mkNixosConfiguration =
    name: machine:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        (
          { config, lib, ... }:
          {
            options.machine = lib.mkOption {
              type = machineType;
              description = "Machine-specific configuration";
            };

            config = {
              machine = machine // {
                users = machine.users // {
                  forAll = cfg: lib.mapAttrs (_: _: cfg) machine.users.users;
                  forAdmins =
                    cfg: lib.mapAttrs (_: _: cfg) (lib.filterAttrs (_: v: v == "admin") machine.users.users);
                  forGuests =
                    cfg: lib.mapAttrs (_: _: cfg) (lib.filterAttrs (_: v: v == "guest") machine.users.users);
              };
              };

              nixpkgs.config.allowUnfreePredicate =
                pkg: builtins.elem (lib.getName pkg) config.machine.nixpkgs.allowUnfreePredicate;

              nixpkgs.hostPlatform = lib.mkDefault machine.system;

              networking = {
                domain = machine.domain;
                hostName = name;
              };

              time.timeZone = machine.timeZone;

              users.users =
                (config.machine.users.forAll { isNormalUser = true; })
                // (config.machine.users.forAdmins {
                isNormalUser = true;
                  extraGroups = [ "wheel" ];
                });
            };
          }
        )
        inputs.self.modules.nixos.profiles-base
        inputs.self.modules.nixos."profiles-${machine.profile}"
        inputs.self.modules.nixos."${name}"
      ];
    };
in
{
  options.flake.machines = lib.mkOption {
    type = lib.types.attrsOf machineType;
    description = "Machine definitions that will generate NixOS configurations";
  };

  config.flake.nixosConfigurations = lib.pipe inputs.self.machines [
      (lib.filterAttrs (_: machine: lib.hasInfix "linux" machine.system))
    (lib.mapAttrs mkNixosConfiguration)
    ];
}

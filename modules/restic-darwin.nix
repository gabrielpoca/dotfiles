{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.services.restic-darwin;

  backupOptions = { name, ... }: {
    options = {
      path = lib.mkOption {
        type = lib.types.str;
        description = "Local path to backup";
        example = "/Users/gabriel/Documents";
      };

      repository = lib.mkOption {
        type = lib.types.str;
        description = "Restic repository";
        example = "b2:bucket-name:/path";
      };

      pruneOpts = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [
          "--keep-daily"
          "7"
          "--keep-weekly"
          "5"
          "--keep-monthly"
          "12"
        ];
        description = "Options for restic forget --prune";
      };

      backupTime = lib.mkOption {
        type = lib.types.attrs;
        default = {
          Hour = 2;
          Minute = 0;
        };
        description = "Time to run backup (launchd StartCalendarInterval format)";
      };

      pruneTime = lib.mkOption {
        type = lib.types.attrs;
        default = {
          Weekday = 0;
          Hour = 3;
          Minute = 0;
        };
        description = "Time to run prune (launchd StartCalendarInterval format)";
      };
    };
  };
in
{
  options.services.restic-darwin = {
    backups = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule backupOptions);
      default = { };
      description = "Restic backup configurations";
      example = lib.literalExpression ''
        {
          icloud = {
            path = "/Users/gabriel/Library/Mobile Documents/com~apple~CloudDocs";
            repository = "b2:bucket:/icloud";
          };
        }
      '';
    };
  };

  config = lib.mkIf (cfg.backups != { }) {
    home-manager.users.gabriel = {
      home.packages = [ pkgs.restic ];

      launchd.agents = lib.mkMerge (
        lib.mapAttrsToList (
          name: backup:
          let
            backupScript = pkgs.writeShellScript "restic-backup-${name}" ''
              export B2_ACCOUNT_ID=$(cat ${config.sops.secrets."backup_b2_account_id".path})
              export B2_ACCOUNT_KEY=$(cat ${config.sops.secrets."backup_b2_account_key".path})
              export RESTIC_PASSWORD=$(cat ${config.sops.secrets."restic_password".path})
              ${pkgs.restic}/bin/restic backup "${backup.path}" --repo ${backup.repository}
            '';
            pruneScript = pkgs.writeShellScript "restic-prune-${name}" ''
              export B2_ACCOUNT_ID=$(cat ${config.sops.secrets."backup_b2_account_id".path})
              export B2_ACCOUNT_KEY=$(cat ${config.sops.secrets."backup_b2_account_key".path})
              export RESTIC_PASSWORD=$(cat ${config.sops.secrets."restic_password".path})
              ${pkgs.restic}/bin/restic forget --prune --repo ${backup.repository} ${lib.concatStringsSep " " backup.pruneOpts}
            '';
          in
          {
            "restic-backup-${name}" = {
              enable = true;
              config = {
                ProgramArguments = [ "${backupScript}" ];
                StartCalendarInterval = [ backup.backupTime ];
                StandardOutPath = "${config.users.users.gabriel.home}/Library/Logs/restic-backup-${name}.log";
                StandardErrorPath = "${config.users.users.gabriel.home}/Library/Logs/restic-backup-${name}-error.log";
              };
            };

            "restic-prune-${name}" = {
              enable = true;
              config = {
                ProgramArguments = [ "${pruneScript}" ];
                StartCalendarInterval = [ backup.pruneTime ];
                StandardOutPath = "${config.users.users.gabriel.home}/Library/Logs/restic-prune-${name}.log";
                StandardErrorPath = "${config.users.users.gabriel.home}/Library/Logs/restic-prune-${name}-error.log";
              };
            };
          }
        ) cfg.backups
      );
    };
  };
}

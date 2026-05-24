{ lib, ... }:

{
  tmux.modules = [
    ({ config, lib, ... }: {
      options.statusBar = {
        enable = lib.mkEnableOption "status bar" // { default = true; };

        position = lib.mkOption {
          type = lib.types.enum [ "top" "bottom" ];
          default = "bottom";
          description = "Status bar position.";
        };

        left = lib.mkOption {
          type = lib.types.str;
          default = "[#S]";
          description = "Left side of status bar.";
        };

        right = lib.mkOption {
          type = lib.types.str;
          default = "%Y-%m-%d %H:%M";
          description = "Right side of status bar.";
        };
      };

      config.tmux.rc = lib.mkIf config.statusBar.enable (lib.mkOrder 30 ''
        set -g status-position ${config.statusBar.position}
        set -g status on
        set -g status-left "${config.statusBar.left}"
        set -g status-right "${config.statusBar.right}"
      '');
    })
  ];
}

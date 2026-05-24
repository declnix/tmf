{ lib, ... }:

{
  tmux.modules = [
    ({ config, lib, ... }: {
      options.prefix = lib.mkOption {
        type = lib.types.str;
        default = "C-a";
        description = "Tmux prefix key.";
      };

      config.tmux.rc = lib.mkOrder 10 ''
        set -g prefix ${config.prefix}
        unbind C-b
        bind-key ${config.prefix} send-prefix
      '';
    })
  ];
}

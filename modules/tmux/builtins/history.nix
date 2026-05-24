{ lib, ... }:

{
  tmux.modules = [
    ({ config, lib, ... }: {
      options.history = lib.mkOption {
        type = lib.types.int;
        default = 50000;
        description = "Number of lines to keep in history.";
      };

      config.tmux.rc = lib.mkOrder 10 ''
        set -g history-limit ${toString config.history}
      '';
    })
  ];
}

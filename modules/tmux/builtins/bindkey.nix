{ lib, ... }:

{
  tmux.modules = [
    ({ config, lib, ... }: {
      options.bindkey = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        example = {
          "C-c" = "kill-session";
          "C-n" = "new-window";
        };
        description = "Custom key bindings. Keys are tmux bind specs, values are commands.";
      };

      config.tmux.rc = lib.mkOrder 20 (
        lib.concatStringsSep "\n" (
          lib.mapAttrsToList (key: cmd: "bind-key ${key} '${cmd}'") config.bindkey
        )
      );
    })
  ];
}

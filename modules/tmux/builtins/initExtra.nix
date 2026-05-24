{ lib, ... }:

{
  tmux.modules = [
    ({ config, lib, ... }: {
      options.initExtra = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Free-form tmux code, emitted near the end of the generated tmux.conf.";
      };

      config.tmux.rc = lib.mkOrder 900 config.initExtra;
    })
  ];
}

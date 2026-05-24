{ lib, ... }:

{
  tmux.modules = [
    ({ config, lib, pkgs, ... }: {
      options.plugins.sensible.enable = lib.mkEnableOption "tmux-sensible";

      config = lib.mkIf config.plugins.sensible.enable {
        tmux.plugins.sensible = {
          package = pkgs.tmuxPlugins.sensible;
          source = "share/tmux-plugins/sensible/sensible.tmux";
        };
      };
    })
  ];
}

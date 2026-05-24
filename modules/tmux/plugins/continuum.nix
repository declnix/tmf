{ lib, ... }:

{
  tmux.modules = [
    ({ config, lib, pkgs, ... }: {
      options.plugins.continuum.enable = lib.mkEnableOption "tmux-continuum";

      config = lib.mkIf config.plugins.continuum.enable {
        tmux.plugins.continuum = {
          package = pkgs.tmuxPlugins.continuum;
          source = "share/tmux-plugins/continuum/continuum.tmux";
          init = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '15'
          '';
          after = [ "resurrect" ];
        };
      };
    })
  ];
}

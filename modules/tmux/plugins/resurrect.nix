{ lib, ... }:

{
  tmux.modules = [
    ({ config, lib, pkgs, ... }: {
      options.plugins.resurrect.enable = lib.mkEnableOption "tmux-resurrect";

      config = lib.mkIf config.plugins.resurrect.enable {
        tmux.plugins.resurrect = {
          package = pkgs.tmuxPlugins.resurrect;
          source = "share/tmux-plugins/resurrect/resurrect.tmux";
          init = ''
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-strategy-nvim 'session'
          '';
          after = [ "sensible" ];
        };
      };
    })
  ];
}

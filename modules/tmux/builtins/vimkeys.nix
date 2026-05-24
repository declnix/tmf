{ lib, ... }:

{
  tmux.modules = [
    ({ config, lib, ... }: {
      options.vimKeys = lib.mkEnableOption "vim-style keybindings";

      config.tmux.rc = lib.mkIf config.vimKeys (lib.mkOrder 20 ''
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        bind -r C-h select-window -t :-
        bind -r C-l select-window -t :+
      '');
    })
  ];
}

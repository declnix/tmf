{ self, ... }:

{
  perSystem =
    { pkgs, ... }:

    let
      conf =
        self.lib.tmuxConfiguration {
          inherit pkgs;
          modules = [
            {
              plugins = {
                sensible.enable = true;
                resurrect.enable = true;
                continuum.enable = true;
              };
              prefix = "C-a";
              history = 50000;
              vimKeys = true;
              statusBar.enable = true;
              statusBar.position = "bottom";
              initExtra = ''
                # Custom user configuration
              '';
            }
          ];
        };

      package =
        pkgs.symlinkJoin {
          name = "tmux";
          paths = [ pkgs.tmux ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/tmux \
              --add-flags "-f ${conf}"
          '';
        };

      nestedWrapper = pkgs.writeShellScript "tmux-nested" ''
        unset TMUX
        exec ${package}/bin/tmux "$@"
      '';

    in {
      packages.default = package;

      apps.default = {
        type = "app";
        program = "${package}/bin/tmux";
      };

      apps.nested = {
        type = "app";
        program = "${nestedWrapper}";
      };
    };
}

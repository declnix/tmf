{ lib, inputs, config, ... }:

let
  tmuxConfiguration =
    { pkgs, modules ? [ ], specialArgs ? { } }:
    let
      dag = inputs.dag.lib { inherit lib; };
      evaluated = lib.evalModules {
        modules = config.tmux.modules ++ modules;
        specialArgs = {
          inherit pkgs;
          tmuxLib = { inherit dag; };
        } // specialArgs;
      };
    in
      pkgs.writeText "tmux.conf" evaluated.config.tmux.rc;

in {
  flake.lib.tmuxConfiguration = tmuxConfiguration;
  flake-file.inputs.dag.url = "github:denful/dag";
}

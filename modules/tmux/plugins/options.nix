{ lib, ... }:

let
  pluginSubmodule = lib.types.submodule {
    options = {
      package = lib.mkOption {
        type = lib.types.package;
        description = "Package containing plugin scripts.";
      };

      source = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Single plugin script path inside the package.";
      };

      sources = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Ordered list of plugin script paths inside the package.";
      };

      init = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Additional tmux commands run after sourcing plugin files.";
      };

      after = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Plugin names that must load before this plugin.";
      };
    };
  };

  module = { config, lib, ... }: {
    options.tmux.plugins = lib.mkOption {
      type = lib.types.attrsOf pluginSubmodule;
      default = { };
      description = "Plugin registry consumed by the config renderer.";
    };

    options.tmux.extraPlugins = lib.mkOption {
      type = lib.types.attrsOf pluginSubmodule;
      default = { };
      description = "Additional plugins merged into tmux.plugins.";
    };
  };

in {
  tmux.modules = [ module ];
}

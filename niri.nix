{ config, pkgs, inputs, ... }:

let
  brightnessControl = pkgs.callPackage ./scripts/brightness.nix {};
in

{
  home.packages = [
    brightnessControl
  ];

  programs.niri = {
    enable = true;
    package = inputs.niri-flake.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;

    settings = {
      # 1. COMPORTAMENTO E APARÊNCIA BASE
      prefer-no-csd = true;

      # Executar Programas
      spawn-at-startup = [
        { command = [  "noctalia-shell" ];}
        { command = [ "xwayland-satellite" ];}
        { command = [ "wl-gammarelay-rs" ];}
      ];
 
      # Desativar Tela de Boas Vindas
      hotkey-overlay = {
        skip-at-startup = true;
      };

      # Configurações de input e teclado local
      input = {
        keyboard = {
          xkb = {
            layout = "br";
          };
        };
        touchpad = {
          tap = true;
          natural-scroll = false;
        };
      };

      # Configuração do Layout de Janelas (Gaps e Bordas)
      layout = {
        gaps = 8;
        focus-ring = {
          enable = true;
          width = 3;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };
      };

      # 2. SEÇÃO DE ATALHOS (BINDS) - Limpa e Unificada
      binds = {
        # Atalhos de Sistema e Aplicativos
        "Mod+T".action.spawn = "kitty";
        "Mod+B".action.spawn = "firefox"; # Corrigido aqui: Mod+B abre o navegador
        "Mod+Q".action.close-window = [];
        "Mod+Shift+E".action.quit = [];

        # Funções da Tecla fn+
        "XF86MonBrightnessUp".action.spawn = [ "brightnessControl" "+" ];
        "XF86MonBrightnessDown".action.spawn = [ "brightnessControl" "-" ];
        "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" ];
        "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
        "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];

        # Navegação de Foco (Mover entre colunas/janelas)
        "Mod+Left".action.focus-column-left = [];
        "Mod+Right".action.focus-column-right = [];
        "Mod+Down".action.focus-window-down = [];
        "Mod+Up".action.focus-window-up = [];

        # Movimentação Física de Janelas (Mudar de lugar)
        "Mod+Shift+Left".action.move-column-left = [];
        "Mod+Shift+Right".action.move-column-right = [];
        "Mod+Shift+Down".action.move-window-down = [];
        "Mod+Shift+Up".action.move-window-up = [];

        # Redimensionamento e Foco de Monitores
        "Mod+F".action.maximize-column = [];
        "Mod+Shift+F".action.fullscreen-window = [];
        "Mod+R".action.switch-preset-column-width = [];

        # Gerenciamento de Espaços de Trabalho (Workspaces Horizontais)
        "Mod+Page_Down".action.focus-workspace-down = [];
        "Mod+Page_Up".action.focus-workspace-up = [];
        "Mod+Shift+Page_Down".action.move-window-to-workspace-down = [];
        "Mod+Shift+Page_Up".action.move-window-to-workspace-up = [];

        # Movimentação entre Workspaces Utiliando Mouse
        "Mod+WheelScrollDown".action.focus-workspace-down = [];
        "Mod+WheelScrollUp".action.focus-workspace-up = [];
        "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [];

        # Ir direto para um Workspace (1 a 9)
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        # Mover colunas para Workspaces específicos
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;
      };
    };
  };
}

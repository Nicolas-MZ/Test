{ pkgs, ... }:

pkgs.writeShellScriptBin "brightnessControl" ''
  #!/usr/bin/env bash
  ACAO=$1
  VALOR=$2
  VALOR_PERCENTUAL="5%"

  # ==============================================================================
  # 1. MÉTODO: TELA NATIVA DO NOTEBOOK (BACKLIGHT HARDWARE)
  # ==============================================================================
  tentar_backlight() {
      if [ "$ACAO" = "+" ]; then
          ${pkgs.brightnessctl}/bin/brightnessctl -d "*:backlight" set "+$VALOR_PERCENTUAL" && return 0
      elif [ "$ACAO" = "-" ]; then
          ${pkgs.brightnessctl}/bin/brightnessctl -d "*:backlight" set "$VALOR_PERCENTUAL-" && return 0
      elif [ "$ACAO" = "set" ]; then
          ${pkgs.brightnessctl}/bin/brightnessctl -d "*:backlight" set "$VALOR%" && return 0
      fi
      return 1
  } # <--- Corrigido aqui: fechamento com chaves

  # ==============================================================================
  # 2. MÉTODO: MONITOR EXTERNO DESKTOP (DDCUTIL HARDWARE)
  # ==============================================================================
  tentar_ddcutil() {
      if [ "$ACAO" = "+" ]; then
          ${pkgs.ddcutil}/bin/ddcutil setvcp 10 + 5 --noverify 2>/dev/null && return 0
      elif [ "$ACAO" = "-" ]; then
          ${pkgs.ddcutil}/bin/ddcutil setvcp 10 - 5 --noverify 2>/dev/null && return 0
      elif [ "$ACAO" = "set" ]; then
          ${pkgs.ddcutil}/bin/ddcutil setvcp 10 "$VALOR" --noverify 2>/dev/null && return 0
      fi
      return 1
  } # <--- Corrigido aqui: fechamento com chaves

  # ==============================================================================
  # 3. MÉTODO: FALLBACK UNIVERSAL POR SOFTWARE (WL-GAMMARELAY-RS)
  # ==============================================================================
  tentar_gammarelay() {
      if [ "$ACAO" = "+" ]; then
          busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d 0.05 && return 0
      elif [ "$ACAO" = "-" ]; then
          # Trava de segurança para o atalho de teclado
          BRILHO_ATUAL=$(busctl --user get-property rs.wl-gammarelay / rs.wl.gammarelay Brightness | awk '{print $2}')
          if (( $(echo "$BRILHO_ATUAL <= 0.10" | bc -l) )); then return 0; fi
          busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d -0.05 && return 0
      elif [ "$ACAO" = "set" ]; then
          # Converte o valor do slider (0-100) para decimal (0.0-1.0)
          VALOR_DECIMAL=$(echo "scale=2; $VALOR / 100" | bc -l)
          # Trava de segurança para o slider da interface gráfica
          if (( $(echo "$VALOR_DECIMAL < 0.10" | bc -l) )); then VALOR_DECIMAL="0.10"; fi
          busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Brightness d "$VALOR_DECIMAL" && return 0
      fi
      return 1
  }

  # ==============================================================================
  # ORDEM DE EXECUÇÃO EM CASCADA (FALBACK)
  # comente ou desative a linha que você não quiser que o script tente rodar!
  # ==============================================================================
  #tentar_backlight && exit 0
  #tentar_ddcutil   && exit 0
  tentar_gammarelay && exit 0
''

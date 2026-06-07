{ config, pkgs, inputs, ... }:

{ 
  imports = [
    ./niri.nix
  ];

  home.username = "kyooto";
  home.homeDirectory = "/home/kyooto";
  programs.git.enable = true;
  home.stateVersion = "26.05";

  xdg = {
    enable = true;
    userDirs = {
     enable = true;
     createDirectories = true;
     publicShare = null;
     templates = null;
     projects = null;
    };
  };

  home.file.".nanorc".text = ''
    set tabsize 4
    set tabstospaces
  '';

  programs.bash = {
    enable = true;
    historyFile = "${config.xdg.cacheHome}/bash_history";
    shellAliases = {
      btw = "echo I use nixos, btw";
    };

    # Convert Json to Nix
    initExtra = ''
      conJsNx() {
          # Verifica se os dois argumentos foram passados
          if [ -z "$1" ] || [ -z "$2" ]; then
              echo "Erro: Você precisa passar o arquivo JSON de entrada e o arquivo NIX de saída."
              echo "Uso: conJsNx nome.json nome.nix"
              return 1
          fi

          # Executa a conversão usando o nix eval e o alejandra
          nix eval --impure --expr "builtins.fromJSON (builtins.readFile ./$1)" | nix run nixpkgs#alejandra > "$2"
      }
    '';
  };
}

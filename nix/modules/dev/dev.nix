{ self, ... }:
{
    perSystem = { pkgs, ... }: {
        packages.dev = pkgs.writeShellApplication {
            name = "dev";
            runtimeInputs = [ pkgs.nix ];
            text = ''
            DOTFILES="$HOME/.dotfiles/nix"
            LANGS_DIR="$DOTFILES/modules/dev/langs"
            STATE_DIR="''${XDG_RUNTIME_DIR:-/tmp}/dev-env"
            STATE_FILE="$STATE_DIR/active"
            mkdir -p "$STATE_DIR"
            touch "$STATE_FILE"
            case "''${1:-}" in
                list)
                    find "$LANGS_DIR" -maxdepth 1 -name '*.nix' -printf '%f\n' | sed 's/\.nix$//'
                ;;
                active)
                    if [ -s "$STATE_FILE" ]; then cat "$STATE_FILE"; else echo "(none active)"; fi
                ;;
                unset)
                    if [ -z "''${2:-}" ]; then
                        to_remove=$(cat "$STATE_FILE")
                        : > "$STATE_FILE"
                    else
                        to_remove="$2"
                        grep -vFx "$2" "$STATE_FILE" > "$STATE_FILE.tmp" || true
                        mv "$STATE_FILE.tmp" "$STATE_FILE"
                    fi
                    for lang in $to_remove; do
                    path=$(nix path-info "$DOTFILES#$lang" 2>/dev/null || true)
                    if [ -n "$path" ]; then
                        echo "[dev] removing $lang from store..."
                        nix store delete "$path" 2>/dev/null || echo "[dev] $lang: shared dependencies kept (still used elsewhere)"
                    fi
                    done
                    if [ -s "$STATE_FILE" ]; then
                          installables=()
                          while IFS= read -r lang; do installables+=("$DOTFILES#$lang"); done < "$STATE_FILE"
                          echo "[dev] active: $(tr '\n' ' ' < "$STATE_FILE")"
                          exec nix shell "''${installables[@]}"
                    else
                        echo "[dev] no languages active"
                        exec nix shell
                    fi
                ;;
                help|"")
                    echo "Usage: dev <lang...> | dev list | dev active | dev unset [lang]"
                ;;
                *)
                    for lang in "$@"; do
                      if [ ! -f "$LANGS_DIR/$lang.nix" ]; then
                        echo "[dev] unknown language: $lang (run 'dev list' to see available)" >&2
                        exit 1
                      fi
                    done
                    printf '%s\n' "$@" >> "$STATE_FILE"
                    sort -u -o "$STATE_FILE" "$STATE_FILE"
                    installables=()
                    while IFS= read -r lang; do installables+=("$DOTFILES#$lang"); done < "$STATE_FILE"
                    echo "[dev] activating: $(tr '\n' ' ' < "$STATE_FILE")"
                    export DEV_SHELL_ACTIVE=1
                    exec nix shell "''${installables[@]}"
                ;;
                esac
            '';
        };
    };

    flake.nixosModules.dev = { pkgs, ... }: {
        environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.dev ];
        programs.bash.interactiveShellInit = ''
        __dev_state="''${XDG_RUNTIME_DIR:-/tmp}/dev-env/active"
        __dev_langs="$HOME/.dotfiles/nix/modules/dev/langs"
        if [ -z "''${DEV_SHELL_ACTIVE:-}" ] && [ -s "$__dev_state" ]; then
            __valid=$(grep -Fxf <(find "$__dev_langs" -maxdepth 1 -name '*.nix' -printf '%f\n' | sed 's/\.nix$//') "$__dev_state" || true)
            if [ -n "$__valid" ]; then
                export DEV_SHELL_ACTIVE=1
                echo "[dev] restoring: $(echo "$__valid" | tr '\n' ' ')"
                exec nix shell $(echo "$__valid" | sed "s|^|$HOME/.dotfiles/nix#|")
            fi
        fi
        '';  
    };
}

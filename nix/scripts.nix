{ inputs, ... }: 

{
    perSystem = { pkgs, ... }: {
        packages.dotfiles-scripts = pkgs.stdenv.mkDerivation {
            pname = "dotfiles-scripts";
            version = "0.1.0";

            src = inputs.dotfiles-scripts;

            installPhase = ''
                mkdir -p $out/bin
            
            # Copy all shell scripts and make them executable
            for script in *.sh; do
                  if [ -f "$script" ]; then
                    # Remove .sh extension for cleaner command names
                    scriptName=''${script%.sh}
                    cp "$script" "$out/bin/$scriptName"
                    chmod +x "$out/bin/$scriptName"
                  fi
                done
            '';

            meta = with pkgs.lib; {
              description = "Personal dotfiles management scripts";
              license = licenses.mit;
              platforms = platforms.linux;
            };
        };
    };
}


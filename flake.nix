{
  description = "Lightweight and improved fortune";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in {
      packages = forAll (pkgs: rec {
        data = pkgs.runCommand "dice-data" {} ''
          mkdir -p $out/share
          cp ${./share/fortune} $out/share/fortune
          ${pkgs.fortune}/bin/strfile -s $out/share/fortune $out/share/fortune.dat
        '';

        default = pkgs.symlinkJoin {
          name = "dice";
          paths = [
            (pkgs.writeShellScriptBin "dice" (builtins.readFile ./bin/dice))
          ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/dice \
              --prefix PATH : ${nixpkgs.lib.makeBinPath [ pkgs.fortune ]} \
              --set-default DICE_FORTUNE ${data}/share/fortune
          '';
        };

        dist = pkgs.runCommand "dice-dist" {} ''
          mkdir -p $out/bin
          ${pkgs.bash}/bin/bash ${self}/build.sh $out/bin/dice
        '';
      });

      apps = forAll (pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/dice";
        };
      });
    };
}

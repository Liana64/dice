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

        default = pkgs.writeShellScriptBin "dice" ''
          exec ${pkgs.fortune}/bin/fortune "''${DICE_FORTUNE:-${data}/share/fortune}"
        '';

        dist = pkgs.runCommand "dice-dist" {} ''
          mkdir -p $out/bin
          cd ${self}
          ${pkgs.bash}/bin/bash build.sh $out/bin/dice
        '';
      });

      apps = forAll (pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${pkgs.system}.default}/bin/dice";
        };
      });
    };
}

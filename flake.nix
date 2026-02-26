{
     description = "DIY K9 Lost Boys K9 - SvelteKit dev env";
     inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      };
     outputs = { self, nixpkgs }:
     let
       systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
       forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
     in
     {
       devShells = forAllSystems (system:
       let
        pkgs = nixpkgs.legacyPackages.${system};
        in
        {
         default = pkgs.mkShell {
           name = "diyk9-lostboysk9-dev";
           buildInputs = with pkgs; [ nodejs_25 nodePackages.pnpm git ];
           shellHook = ''
              echo ""
              echo "========================================"
              echo "  DIYK9 LostBoysK9 Dev Shell"
              echo "========================================"
             echo "DIY K9 Dev Shell | Node: $(node --version)"
             echo "pnpm run dev | pnpm run build"
           '';
         };
       });
     };
   }

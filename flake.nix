{
  description = "A very basic flake";



  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      # https://discourse.nixos.org/t/how-to-fetch-lfs-enabled-repo-with-fetchfromgithub/5890/3
      japanese-gpt2-medium = pkgs.fetchgit {
        url = "https://huggingface.co/rinna/japanese-gpt2-medium";
        branchName = "main";
        rev = "f464b76739c884d8b0479a0a7705b7fa71c3fd5a";
        sha256 = "0x804k6b6gv3pfvna1ffhb2f6h0nsimzb8h8hgql9ihng439cagm";
        fetchLFS = true;
      };
    in
    {

      packages.x86_64-linux.japanese-gpt2-medium = pkgs.stdenv.mkDerivation {
        src = japanese-gpt2-medium;
        name = "japanese-gpt2-medium";
        installPhase = ''
          cp -r $src $out
        '';
      };


      devShells.x86_64-linux.default =
        let python-with-packages = pkgs.python39.withPackages (p: with p; [
          pytorch
          sentencepiece
          transformers
        ]); in
        pkgs.mkShell {
          buildInputs = [
            python-with-packages
            pkgs.pyright
            self.packages.x86_64-linux.japanese-gpt2-medium
          ];
          shellHook = ''
            export PYTHONPATH=${python-with-packages}/${python-with-packages.sitePackages}
            export MODELPATH=${self.packages.x86_64-linux.japanese-gpt2-medium}
          '';
        };

    };
}

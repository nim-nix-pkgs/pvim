{
  description = ''A vim-based editor'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-pvim-0_11_0.flake = false;
  inputs.src-pvim-0_11_0.owner = "paranim";
  inputs.src-pvim-0_11_0.ref   = "refs/tags/0.11.0";
  inputs.src-pvim-0_11_0.repo  = "pvim";
  inputs.src-pvim-0_11_0.type  = "github";
  
  inputs."paravim".owner = "nim-nix-pkgs";
  inputs."paravim".ref   = "master";
  inputs."paravim".repo  = "paravim";
  inputs."paravim".type  = "github";
  inputs."paravim".inputs.nixpkgs.follows = "nixpkgs";
  inputs."paravim".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-pvim-0_11_0"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-pvim-0_11_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
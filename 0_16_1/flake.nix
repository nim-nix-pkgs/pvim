{
  description = ''A vim-based editor'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-pvim-0_16_1.flake = false;
  inputs.src-pvim-0_16_1.owner = "paranim";
  inputs.src-pvim-0_16_1.ref   = "refs/tags/0.16.1";
  inputs.src-pvim-0_16_1.repo  = "pvim";
  inputs.src-pvim-0_16_1.type  = "github";
  
  inputs."paravim".dir   = "nimpkgs/p/paravim";
  inputs."paravim".owner = "riinr";
  inputs."paravim".ref   = "flake-pinning";
  inputs."paravim".repo  = "flake-nimble";
  inputs."paravim".type  = "github";
  inputs."paravim".inputs.nixpkgs.follows = "nixpkgs";
  inputs."paravim".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-pvim-0_16_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-pvim-0_16_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
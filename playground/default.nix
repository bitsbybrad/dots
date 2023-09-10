# REFERENCES
# https://nixos.org/guides/nix-pills/basics-of-language for language basics
# https://nix.dev/tutorials/first-steps/nix-language for a walkthrough

# USING THIS FILE:
# uncomment small sections to see the results.
# run this file with nix-instantiate --eval ( optionally add --strict)
# or use the evaluate script in the root of the repo.
{
  # # VALUE TYPES
  # string = "foo";
  # int = 1;
  # float = 3.141;
  # bool = true;
  # null = null;
  # list = [ 1 2 3 4 5 "a string" false]; # like tuple or array. no commas though
  # attrSet = { # like a map or object. keys must be unique.
  #   a = "some value";
  #   b = "some other value";
  # };


  # # MATH OPERATIONS
  # multiplication = 5 * 5;
  # division = 25 / 5; # important to leave spaces while dividing. otherwise nix might read it as a path. you could also use builtins.div if you needed a lamba that did this.
  # addition = 1 + 1;
  # subtraction = 1 - 2;

  # # RECURSIVE ATTRIBUTE SET (using recursive to self reference it's internals)
  # recursive = rec {
  #   one = 1;
  #   two = one + 1;
  #   three = two + 1;
  # };


  # # LET EXPRESSION
  # letExpression = let a = 1; in a + a;

  # # ATTRIBUTE ACCESS
  # access = let set = { x = 1; }; in set.x;

  # # WITH EXPRESSION
  # withExpression = let a = { x=1; y=2; z=3; }; in with a; [x y z];

  # # INHERIT - inherit allows you to reuse names from a previously established scope.
  # inheritShorthand = let x = 1; y = 2; in { inherit x y; };
  # # this grabs only the attribute x from a. try swapping (a) for (b)
  # inheritAttribute = let a = { x = 1; }; b = { x = 2; }; in { inherit (b) x; };

  # # PATH EXAMPLES
  # relativePath = ./relative;
  # upDirectory = ../updir;
  # homeDirectory = ~/somewhere/from/home;
  # currentDirectory = ./.;

  # # LAMDAS
  # single-arg-lamda = rec {
  #   addOne = x: x + 1;
  #   addOne_out = addOne 1;
  # };

  # curried-lambda = rec {
  #   sum = x: y: x + y;
  #   sum_out = sum 2 3;
    
  #   # ez currying
  #   addFive = sum 5;
  #   addOne_out = addFive 2;
  # };

  # attr-spread = rec {
  #   mult = { a, b }: a * b;
  #   mult_out = mult { a = 2; b = 5; }; # === 10

  #   # currying is still super ez. you just need to have default values.
  #   # its important to note that in this example you could screw this up if you mixed integers and floats
  #   # this is a contrived example but could be very powerful for currying smaller parts of a greater type def together.
  #   div = { divisor ? 1.0 } : { dividend ? 1.0 }: dividend / divisor;
  #   divByTwo = div { divisor = 2; };
  #   div_out = divByTwo { dividend = 5.0; }; # === 5

  # };

  # additional-attr = rec {
  #   # this allows you to pass other potentially unrelated values to a lambda
  #   agnosticAdd = { a, b, ...}: a + b;
  #   result = agnosticAdd { a = 1; b = 2; c = 3; }; # === 3
  # };

  # named-attr = rec {
  #   # this could also be prepended
  #   appended = { a, b, ... }@args: a + b + args.c;
  #   prepended = args@{ a, b, ...}: a + b + args.c;
  #   sumByAB = c: appended { a = 2; b = 5; c = c; };
  #   result_AB-C = sumByAB 3; # === 10

  #   # this is effectively the same. its just another option.
  #   sumByAC = b: prepended { a = 2; b = b; c = 3;};
  #   result_AC-B = sumByAC 5; # === 10
  # };

  # OPERATORS
  # https://nixos.org/manual/nix/stable/language/operators.html

  # negation = rec {
  #   num = 1;
  #   negative_num = -num;
  # };

  # has-attr = rec {
  #   obj = { some = "thing"; };
  #   has = obj ? some;
  # };

  # type-collapse = rec {
  #   a = { some = "thing"; };
  #   b = { another = "value"; };
  #   # merge two attribute sets together.
  #   c = a // b;
  #   # if a duplicate key is merged. the last one in wins.
  #   d = { another = "different value"; };
  #   e = c // d;
  # };

  # list-concat = rec {
  #   a = [ 1 2 3 ];
  #   b = [ "other" "stuff" 4 5 6 ];
  #   c = a ++ b;
  # };

  # logical-implication = rec {
  #   a = 1;
  #   b = 2;
  #   c = a == b;
  #   d = b * 2 == 4;
  #   and = c && d; #false
  #   or = c || d; #true
  #   not = !c; #true;
  #   nor = !(c || d); #false;
  # };

  ## START HERE TOMORROW.


  #IMPORTING BASIC
  # something = import ./import.nix; # 1

  #IMPORTING FUNCTIONAL 
  result = let
    math =  (import ./math.nix).addOne;
  in rec {
    set = [1 2 3];
    calc = math 2;
    # other = set.1;
  };

  #type checking

  # typecheck = let
  #   inherit (builtins) elem attrNames;
  # in
  # rec {
  #   isValidType = t: elem t [ "int" "bool" "string" "path" "null" "set" "list" "float" ];
  #   c = isValidType "string";

  #   isValidAttr = key: obj: elem key (attrNames obj);
  #   example = { some = "thing"; };
  #   result = isValidAttr "some" example; 
  # };

  # obj = rec {
  #   test = { some = "thing"; };
  #   isSomeAString = builtins.typeOf test.some == "string";
  # };

}

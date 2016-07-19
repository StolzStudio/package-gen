# package-gen
My perl script to generate simple package modules.

## How install?

1. `$ git clone git://github.com/stolzstudio/package-gen.git` or click download button
2. put it in you project or comfortable folder for you
2. ???
3. profit, you amazing!!! 

## How feed this monster?

Script know some constructions:
  
### scalars:

    ("my" or "our") + (variable name) 
 
EXAMPLE:

`myvar1 ourvar2` - convert to:

    my $var1; 
    our $var2;

### arrays:

    ("my" or "our") + (variable name) + ('s')

EXAMPLE:

`myarr1s ourarr2s` - convert to:

    my @arr;
    our @arr;
  
### funstions:

    (sub) + (function name)

EXAMPLE:

`subtes1 subtest2 subtest3` - convert to:

    sub test1 {} 
    sub test2 {}
    sub test3 {}

### BEGIN phase: 
  
when you add functions you can say what functions you want to export
    
just add `(ex)` key after `(sub)` in function constructor
    
EXAMPLE:

`subextest` - convert to: 

    our @EXPORT_OK = qw(test);

and add:

    sub test {}

###use modules:
  
    (mod) + (module name)
    
EXAMPLE:
`modtest1 modtest2` - convert to:

    use test1;
    use test2:
    
IMPORTANT - generator bild himself modules "strict" and "warnings"

###module name and path to save:
    (path to file) + / + (package name)
  
EXAMPLE:

`/users/stolz/git/package-gen/generator` - convert to

    path         - /users/stolz/git/package-gen/
    package name - generator
  
a note - genarator bild file module using a package name

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
    myname ourdate - convert to:
    "my $name; our $date;"

### arrays:
    ("my" or "our") + (variable name) + ('s')
    
    EXAMPLE:
    mybananas ourapples - convert to:
    "my @bananas; our @apples;"
  
### funstions:

    (sub) + (function name)
    
    EXAMPLE:
    subtes1 subtest2 subtest3 - convert to:
    
    sub test1 {} 
    sub test2 {}
    sub test3 {}
### BEGIN phase: 
    
    you can take what functions you want to export
    
    {(function name)..}
    
    EXAMPLE:
    {test parse watch} - convert to: 
    our @EXPORT_OK = qw(test parse watch);
    
    parser this phase know flag "all"
    
    flag "all" say parser to take all functions and put they to export part in BEGIN
    
###use modules:
  
    |(module name)..|
    
    EXAMPLE:
    |tester parser| - convert to:
    use tester;
    use parser:
    
    IMPORTANT - generator bild himself modules "strict" and "warnings"
###module name and path to save:
    (path to file) + / + (package name) + / 
  
    EXAMPLE:
    /users/stolz/git/package-gen/generator/ - convert to
    path         - /users/stolz/git/package-gen/
    package name - generator
  
    a note - genarator bild file module using a package name

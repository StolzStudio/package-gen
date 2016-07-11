package main;

use strict;
use warnings;
use generator;

BEGIN {
  require Exporter;

  our @ISA = qw(Exporter);

  our @EXPORT_OK = qw();
}


generator::gen_header(qw(test_name packet rulet));
generator::gen_begin(qw(func1 func2 func3));
generator::gen_local_variables(qw(a b c d));
generator::gen_global_variables(qw(x y z));
generator::gen_sub(qw(func1 func2));

print $generator::package_source;
1;

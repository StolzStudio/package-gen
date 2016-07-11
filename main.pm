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

print $generator::package_source;
1;

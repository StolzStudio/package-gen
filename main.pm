package main;

use strict;
use warnings;
use generator;

BEGIN {
  require Exporter;

  our @ISA = qw(Exporter);

  our @EXPORT_OK = qw();
}


generator::gen_header("test_name", 24);

print $generator::package_source;
1;

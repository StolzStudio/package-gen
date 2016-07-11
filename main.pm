package main;

use strict;
use warnings;
use generator;

BEGIN {
  require Exporter;

  our @ISA = qw(Exporter);

  our @EXPORT_OK = qw();
}


generator::gen_header(qw(speaker));
generator::gen_begin(qw(hello_message exit_message));
# generator::gen_local_variables(qw(a b c d));
# generator::gen_global_variables(qw(x y z));
generator::gen_sub(qw(hello_message exit_message));
generator::save_to_file(qw(/users/stolz/git/package-gen/ speaker));
print $generator::package_source;
1;

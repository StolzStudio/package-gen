package generator;

use strict;
use warnings;

our $endl = "\n";
our $tab  = "\t";

BEGIN {
  require Exporter;

  our @ISA = qw(Exporter);

  our @EXPORT_OK = qw(gen_header gen_begin);
}

our $package_source;

sub gen_header {
  my ($package_name) = @_;
  $package_source .= "package $package_name;$endl$endl";
  $package_source .= "use strict;$endl" . "use warnings;$endl";

  if ((my $len = @_) > 0) {
    map { $package_source .= "use $_;$endl" }@_;
  }

  $package_source .= "$endl";
}

sub gen_begin {
  my (@package_export_functions) = @_;
  $package_source .= "BEGIN {$endl$tab";
  $package_source .= "require Exporter;$endl$endl$tab";
  $package_source .= 'our @ISA = qw(Exporter);' . "$endl$endl$tab";
  $package_source .= 'our @EXPORT_OK = ' . "qw(" . join(' ', @package_export_functions) . ");$endl}" . "$endl";
}

1;
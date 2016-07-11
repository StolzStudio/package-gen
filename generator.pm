package generator;

use strict;
use warnings;

our $endl = "\n";
our $tab  = "\t";

BEGIN {
  require Exporter;

  our @ISA = qw(Exporter);

  our @EXPORT_OK = qw(gen_header);
}

our $package_source;

sub gen_header {
  my ($package_name) = @_;
  $package_source .= "package $package_name;$endl$endl";
  $package_source .= "use strict;$endl" . "use warnings;$endl$endl";

}

1;

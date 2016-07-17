package generator;

use strict;
use warnings;
use parser;

our $endl = "\n";
our $tab  = "\t";

BEGIN {
  require Exporter;

  our @ISA = qw(Exporter);

  our @EXPORT_OK = qw(gen gen_header gen_begin gen_sub
                      gen_local_variables gen_global_variables
                      save_to_file);
}

our $package_source;

sub gen_header {
  my ($package_name) = shift;
  $package_source .= "package $package_name;$endl$endl";
  $package_source .= "use strict;$endl" . "use warnings;$endl";

  if ((my $len = @_) > 0) {
    map { $package_source .= "use $_;$endl" } @_;
  }

  $package_source .= "$endl";
}

sub gen_begin {
  my (@package_export_functions) = @_;
  $package_source .= "BEGIN {$endl$tab";
  $package_source .= "require Exporter;$endl$endl$tab";
  $package_source .= 'our @ISA = qw(Exporter);' . "$endl$endl$tab";
  $package_source .= 'our @EXPORT_OK = ' . "qw(" . join(' ', @package_export_functions) . ");$endl}" . "$endl$endl";
}

sub gen_sub {
  if ((my $len = @_) > 0) {
    map { $package_source .= 'sub ' . "$_ {$endl";
          $package_source .= "$tab$endl" . "}$endl$endl";
        } @_;
  }
}

sub gen_local_variables {
  my %var = %{shift()};

  write_variables('my', '@', (@{$var{arr}}));
  write_variables('my', '$', (@{$var{scal}}));
}

sub gen_global_variables {
  my %var = %{shift()};

  write_variables('our', '@', (@{$var{arr}}));
  write_variables('our', '$', (@{$var{scal}}));
}

sub write_variables {
  if ((my $len = @_) > 0) {
    my ($type)  = shift;
    my ($sigil) = shift;
    map { $package_source .= "$type " . $sigil . "$_;$endl" } @_;
    $package_source .= "$endl";
  }
}

sub gen {
  gen_header($parser::package_name, @parser::package_modules);
  gen_begin(@parser::package_export_functions);
  gen_global_variables(\%parser::package_our_variables);
  gen_local_variables(\%parser::package_my_variables);
  gen_sub(@parser::package_functions);
  save_to_file(@parser::package_path, $parser::package_name);
}

sub save_to_file {
  my (@path) = @_;
  my $way = "/" . join('/', @path) . ".pm";
  open(STDOUT, '>', $way);
  print($package_source . '1;');
}

1;

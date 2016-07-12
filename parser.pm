package parser;

use strict;
use warnings;
use feature "fc";

BEGIN {
	require Exporter;

	our @ISA = qw(Exporter);

	our @EXPORT_OK = qw(parse_header);
}

my $package_path;
my $package_name;
my @package_modules;
my @package_export_functions;
my @package_functions;
my @package_my_variables;
my @package_our_variables;

sub parse_header {
	$package_path = shift;
	$package_path =~ s|(\w+[^/]$)|$1/|;

	$package_name = shift;
	if ((my $len = @_) > 0) {
		@package_modules = @_;
	}
}

sub parse_begin {
	if ((my $len = @_) = 1) {
		my $flag = shift;
		if (fc("all") eq fc($flag)) {
			@package_export_functions = @package_functions;
		}
	}
}

sub parse_sub {
	@package_functions = @_;
	map { $_ =~ s|sub(\w+)|$1| } @package_functions;
}

1;

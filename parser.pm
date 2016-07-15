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

my $sourse_text;
my $is_text = 0;
my @sourse_arr;

sub parse_header {
	$package_path = shift;
	$package_path =~ s|(\w+[^/]$)|$1/|;

	$package_name = shift;
	if ((my $len = @_) > 0) {
		@package_modules = @_;
	}
}

sub parse_sub {
	if ($is_text) {
		@package_functions = $sourse_text =~ m|(\s*sub\w+\s*)|g;
	} else {
		@package_functions = map { $_ =~ m|(\s*sub\w+\s*)|g } @sourse_arr;
	}
	map {
		if ($_ =~ m|subex(\w+)|) {
			$_ =~ s|subex(\w+)|$1|;
			push(@package_export_functions, $_);
		} else {
			$_ =~ s|sub(\w+)|$1|;
		}
		print "$_\n";
	} @package_functions;
}

sub init_parse_sourse {
	if ((my $len = @_) == 1) {
		$sourse_text = shift;
		$is_text     = 1;
	} else {
		@sourse_arr  = @_;
		$is_text     = 0;
	}
}

1;

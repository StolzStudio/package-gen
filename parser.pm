package parser;

use strict;
use warnings;
use feature "fc";

BEGIN {
	require Exporter;

	our @ISA = qw(Exporter);

	our @EXPORT_OK = qw(
											parse_header, parse_sub, parse_begin,
											parse_module, init_parse_sourse
											);
}

my $package_name;
my @package_pathes;
my @package_modules;
my @package_export_functions;
my @package_functions;
my @package_my_variables;
my @package_our_variables;

my $sourse_text;
my $is_text = 0;
my @sourse_arr;

sub parse_header {
	if ($is_text) {
		@package_pathes = $sourse_text =~ m|/(\w+[^/])|g;

		map { print $_ . "\n"; } @package_pathes;
	} else {
		@package_pathes = map { $_ =~ m|/(\w+[^/])|g } @sourse_arr;
	}

	$package_name = pop @package_pathes;
}

sub parse_module {
	if ($is_text) {
		@package_modules = $sourse_text =~ m|\s*mod\w+\s*|g;
	} else {
		@package_modules = map { $_ =~ m|\s*mod\w+\s*|g } @sourse_arr;
	}
	map { $_ =~ s|mod(\w+)|$1|; print $_ . "\n" } @package_modules;
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

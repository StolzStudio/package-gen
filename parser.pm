package parser;

use strict;
use warnings;
use feature "fc";

BEGIN {
	require Exporter;

	our @ISA = qw(Exporter);

	our @EXPORT_OK = qw(
											parse_header parse_module
											parse_sub parse_var
											init_parse_sourse
											);
}

our $package_name;
our @package_path;
our @package_modules;
our @package_export_functions;
our @package_functions;
our %package_my_variables;
our %package_our_variables;

my $sourse_text;
my $is_text = 0;
my @sourse_arr;

sub parse_header {
	if ($is_text) {
		@package_path = $sourse_text =~ m|/(\w+[^/])|g;
	} else {
		@package_path = map { $_ =~ m|/(\w+[^/])|g } @sourse_arr;
	}

	$package_name = pop @package_path;
}

sub parse_module {
	if ($is_text) {
		@package_modules = $sourse_text =~ m|\s*mod(\w+)\s*|g;
	} else {
		@package_modules = map { $_ =~ m|\s*mod(\w+)\s*|g } @sourse_arr;
	}

	# map { $_ =~ s|mod(\w+)|$1| } @package_modules;
}

sub parse_sub {
	if ($is_text) {
		@package_functions = $sourse_text =~ m|\s*(sub\w+)\s*|g;
	} else {
		@package_functions = map { $_ =~ m|\s*(sub\w+)\s*|g } @sourse_arr;
	}

	map {
		if ($_ =~ m|subex(\w+)|) {
			$_ =~ s|subex(\w+)|$1|;
			push(@package_export_functions, $_);
		} else {
			$_ =~ s|sub(\w+)|$1|;
		}
	} @package_functions;
}

sub parse_var {
	my @my_var;
	my @our_var;

	if ($is_text) {
		@my_var  = $sourse_text =~ m|my\w+|g;
		@our_var = $sourse_text =~ m|our\w+|g;
	} else {
		@my_var  = map { $_ =~ m|my\w+|g  } @sourse_arr;
		@our_var = map { $_ =~ m|our\w+|g } @sourse_arr;
	}
		%package_my_variables  = (
														 'arr'  => [map { $_ =~ m|my(\w+)s$|g;   } @my_var],
														 'scal' => [map { $_ =~ m|my(\w+[^s])$|g } @my_var],
														 );
		%package_our_variables = (
														 'arr'  => [map { $_ =~ m|our(\w+)s$|g;   } @our_var],
														 'scal' => [map { $_ =~ m|our(\w+[^s])$|g } @our_var],
														 );
}

sub parse {
	(my $len = @_) != 0 or die "no text to generate module";

	&init_parse_sourse;
	&parse_header;
	&parse_module;
	&parse_sub;
	&parse_var;
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

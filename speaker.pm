package speaker;

use strict;
use warnings;

BEGIN {
	require Exporter;

	our @ISA = qw(Exporter);

	our @EXPORT_OK = qw(hello_message exit_message);
}

sub hello_message {
	return "glad to meet you in my package module generator\n"
				."type what you want to generate or read simple tutorial (call -help)\n";
}

sub exit_message {
	return "oh, i hope i help you\n"
				."see you later ^.^\n";
}

1;

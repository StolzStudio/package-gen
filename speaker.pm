package speaker;

use strict;
use warnings;

BEGIN {
	require Exporter;

	our @ISA = qw(Exporter);

	our @EXPORT_OK = qw(message_hello message_exit message_finish_generate);
}

sub message_hello {
	return "glad to meet you in my package module generator\n"
				. "if you know how work {\n\ttype what you want to generate\n}"
				. "else {\n\tread readme\n}\n";
}

sub message_finish_generate {
	return "package generate ^.^\n";
}

sub message_exit {
	return "oh, i hope i help you\n"
				."see you later...\n";
}

1;

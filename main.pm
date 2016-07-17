package main;

use strict;
use warnings;
use generator;
use speaker;
use parser;
use feature "fc";

BEGIN {
  require Exporter;

  our @ISA = qw(Exporter);

  our @EXPORT_OK = qw();
}

print speaker::message_hello;

my $text = <STDIN>;
while ($text ne "exit\n") {
  chomp $text;
  parser::parse($text);
  generator::gen;
  print speaker::message_finish_generate;
  $text = <STDIN>;
}

print speaker::message_exit;
1;

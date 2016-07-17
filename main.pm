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

my $text = "";
while (fc($text) ne fc("-exit")) {
  $text = <STDIN>;
  chomp $text;
  parser::parse($text);
  generator::gen;
  print speaker::message_finish_generate;
}

print speaker::message_exit;
1;

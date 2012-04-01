use strict;
use warnings;

use Test::More;
use lib 't/lib';
use TestHighlight 'get_highlighter';

my $highlighter = get_highlighter('Perl');
my $sample = '#!perl
my $x = 3 + $var;';
ok 1;
diag $highlighter->highlightText($sample);


use strict;
use warnings;

use Test::More tests => 1;

use Syntax::Highlight::Engine::Kate;
my $hl = Syntax::Highlight::Engine::Kate->new(
    language => 'Perl',
);

isa_ok($hl, 'Syntax::Highlight::Engine::Kate');

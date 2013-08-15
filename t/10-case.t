use strict;
use warnings;

use Test::More tests => 4;
use Syntax::Highlight::Engine::Kate;

my $hl = new Syntax::Highlight::Engine::Kate();

is($hl->languagePlug( 'HTML'), 'HTML', 'Standard "HTML" should work');
is($hl->languagePlug( 'html'), undef, 'Standard "html" should not work');
is($hl->languagePlug( 'HTML', 1), 'HTML', 'Insesitive "HTML" should work');
is($hl->languagePlug( 'html', 1), 'HTML', 'Insesitive "html" should work');


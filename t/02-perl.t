
use strict;
use warnings;

use Test::More;

use Syntax::Highlight::Engine::Kate;

my @languages = ('Perl', 'PHP (HTML)', 'PHP/PHP');

plan tests => scalar @languages;

foreach my $language (@languages) {
    my $hl = Syntax::Highlight::Engine::Kate->new(
        language => $language,
    );
    isa_ok($hl, 'Syntax::Highlight::Engine::Kate');
}


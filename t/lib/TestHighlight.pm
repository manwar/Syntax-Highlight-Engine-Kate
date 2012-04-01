package TestHighlight;

use strict;
use warnings;
use Syntax::Highlight::Engine::Kate;
use Exporter 'import';
our @EXPORT_OK = 'get_highlighter';

sub get_highlighter {
    my $syntax = shift || 'Perl';
    return Syntax::Highlight::Engine::Kate->new(
        language     => $syntax,
        format_table => {
            map { _make_token($_) }
              qw/
              Alert
              BaseN
              BString
              Char
              Comment
              DataType
              DecVal
              Error
              Float
              Function
              IString
              Keyword
              Normal
              Operator
              Others
              RegionMarker
              Reserved
              String
              Variable
              Warning
              /
        }
    );
}

sub _make_token {
    my $name = shift;
    my $token = lc $name;
    return $name => [ "<$token>" => "</$token>" ];
}

1;

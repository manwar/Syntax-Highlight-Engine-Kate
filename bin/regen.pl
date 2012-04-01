#!/usr/bin/env perl

use lib 't/lib';
use strict;
use warnings;
use File::Find;
use File::Spec::Functions qw(catfile);
use TestHighlight 'get_highlighter';


my %to_highlight;
my $target = 't/perl/todo_highlighted';
find( \&make_highlighted_version, 't/perl/todo', );

$target = 't/perl/highlighted';
find( \&make_highlighted_version, 't/perl/before', );

my $total = keys %to_highlight;
my $current = 0;
while ( my ( $orig, $new ) = each %to_highlight ) {
    $current++;
    print "Processing $current out of $total ($orig)\n";
    my $highlighter = get_highlighter('Perl');
    my $highlighted = $highlighter->highlightText( slurp($orig) );

    open my $fh, '>', $new or die "Cannot open $new for writing: $!";
    print $fh $highlighted;
}

sub slurp {
    my $file = shift;
    open my $fh, '<', $file or die "Cannot open $file for reading: $!";
    return do { local $/; <$fh> };
}

sub make_highlighted_version {
    return unless -f $_ and /\.pl$/;
    $to_highlight{$File::Find::name} = catfile( $target, $_ );
}

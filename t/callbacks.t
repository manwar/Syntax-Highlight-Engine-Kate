use strict;

use Test::More;

my %options = (
	language => 'Perl',
	substitutions => {
	},
	format_table => {
		Alert => sub { "<alert>$_</alert>" },
		BaseN => sub { "<base_n>$_</base_n>" },
		BString => sub { $_ },
		Char => sub { $_ },
		Comment => sub { $_ },
		DataType => sub { $_ },
		DecVal => sub { $_ },
		Error => sub { $_ },
		Float => sub { $_ },
		Function => sub { "<function>$_</function>" },
		IString => sub { $_ },
		Keyword => sub { "<keyword>$_</keyword>" },
		Normal => sub { $_ },
		Operator => sub { $_ },
		Others => sub { $_ },
		RegionMarker => sub { $_ },
		Reserved => sub { $_ },
		String => sub { "<string>$_</string>" },
		Variable => sub { "<variable>$_</variable>" },
		Warning => sub { $_ },
	},
);

use Syntax::Highlight::Engine::Kate;

my $k = Syntax::Highlight::Engine::Kate->new(%options);
isa_ok $k, 'Syntax::Highlight::Engine::Kate';

my $perl = q~#!/usr/bin/perl

use strict;
use warnings;

my $test = 'hallo';
print $test;
~;

my $text = $k->highlightText( $perl );

like $text, qr{<string>hallo</string>};
like $text, qr{<keyword>my</keyword>};

done_testing();

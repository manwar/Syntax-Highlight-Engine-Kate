#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;

use Term::ANSIColor ':constants';
use Syntax::Highlight::Engine::Kate::Perl;

# Test for issue with unescaped left brace in regex deprecation warning
# https://github.com/manwar/Syntax-Highlight-Engine-Kate/issues/19

my %required_format_tags = (
    'Comment'  => [ 'WHITE'  , 'RESET' ],
    'Normal'   => [ 'WHITE'  , 'RESET' ],
    'DataType' => [ 'CYAN'   , 'RESET' ],
    'DecVal'   => [ 'YELLOW' , 'RESET' ],
    'Float'    => [ 'YELLOW' , 'RESET' ],
    'Function' => [ 'GREEN'  , 'RESET' ],
    'BaseN'    => [ 'YELLOW' , 'RESET' ],
    'Keyword'  => [ 'YELLOW' , 'RESET' ],
    'Operator' => [ 'CYAN'   , 'RESET' ],
    'Others'   => [ 'MAGENTA', 'RESET' ],
    'Char'     => [ 'MAGENTA', 'RESET' ],
    'Variable' => [ 'RED'    , 'RESET' ],
    'String'   => [ 'MAGENTA', 'RESET' ],
);

my %format_table = %required_format_tags;

# Override specific ones for our test colors
$format_table{'Keyword'}  = [ YELLOW, RESET ];
$format_table{'Variable'} = [ RED, RESET ];
$format_table{'Normal'}   = [ WHITE, RESET ];
$format_table{'Operator'} = [ CYAN, RESET ];
$format_table{'String'}   = [ MAGENTA, RESET ];
$format_table{'DataType'} = [ CYAN, RESET ];
$format_table{'Function'} = [ GREEN, RESET ];
$format_table{'Comment'}  = [ 'BRIGHT_BLACK', RESET ];

subtest 'No unescaped brace warnings after patch' => sub {
    my $highlighter = Syntax::Highlight::Engine::Kate::Perl->new(
        format_table => \%format_table
    );

    my @test_cases = (
        # Original issue - qq{} with HTML content containing braces
        'my $html = qq{<div class="%s">%s</div>};',

        # Various brace patterns in interpolated strings
        'my $str = qq{simple};',
        'my $str = qq{nested{brace}};',
        'my $str = qq{multiple{braces}here};',
        'my $str = qq{complex {nested {deeply}} example};',
        'my $str = qq{${interpolated} with {braces}};',

        # Edge cases
        'my $str = qq{};',
        'my $str = qq{{};',
        'my $str = qq{ escaped \{ brace };',

        # Other interpolated string forms
        'my $str = qq|with pipe{brace}|;',
        'my $str = qq#with hash{brace}#;',
    );

    for my $code (@test_cases) {
        my @warnings;
        local $SIG{__WARN__} = sub {
            push @warnings, $_[0];
        };

        my $highlighted;
        lives_ok {
            $highlighted = $highlighter->highlightText($code);
        } "highlightText lives for: $code";

        my @brace_warnings = grep { /Unescaped left brace in regex is deprecated/ } @warnings;
        is(scalar(@brace_warnings), 0, "No brace deprecation warnings for: $code");

        is(scalar(@warnings), 0, "No warnings of any kind for: $code")
            or diag "Unexpected warnings: $_" for @warnings;
    }
};

subtest 'Other Perl constructs with braces should be unaffected' => sub {
    my $highlighter = Syntax::Highlight::Engine::Kate::Perl->new(
        format_table => \%format_table
    );

    my @code_constructs = (
        # Hash constructors
        'my $hash = { key => "value" };',
        'my $hashref = { foo => 1, bar => 2 };',

        # Blocks
        'if ($x) { do_something(); }',
        'while ($cond) { process(); }',
        'sub foo { return 42; }',

        # Anonymous subroutines
        'my $sub = sub { return $_[0] * 2 };',

        # Regex with quantifiers
        'my $re = qr/foo{2,4}/;',
        'm/pattern{3}/',

        # Comments (should be completely ignored)
        '# This {comment} should not be highlighted',

        # POD (should be ignored)
        '=head1 Title {with braces}',
        '=cut',

        # Variable with braces
        'my ${var} = 42;',
        'say "${var} in string";',
    );

    for my $code (@code_constructs) {
        my @warnings;
        local $SIG{__WARN__} = sub {
            push @warnings, $_[0];
        };

        my $highlighted;
        lives_ok {
            $highlighted = $highlighter->highlightText($code);
        } "highlightText lives for: $code";

        my @brace_warnings = grep { /Unescaped left brace in regex is deprecated/ } @warnings;
        is(scalar(@brace_warnings), 0, "No brace warnings for: $code");

        is(scalar(@warnings), 0, "No other warnings for: $code")
            or diag "Unexpected warnings: $_" for @warnings;
    }
};

subtest 'Verify the specific testRangeDetect call was patched' => sub {
    my $highlighter = Syntax::Highlight::Engine::Kate::Perl->new(
        format_table => \%format_table
    );

    my $code = 'my $str = qq{content with {nested} braces};';

    my @warnings;
    local $SIG{__WARN__} = sub {
        push @warnings, $_[0];
    };

    my $highlighted = $highlighter->highlightText($code);

    my @brace_warnings = grep { /Unescaped left brace in regex is deprecated/ } @warnings;
    is(scalar(@brace_warnings), 0, 'No unescaped brace warnings from ip_string_3 context');

    ok(length($highlighted) > 0, 'Highlighting produced output');
};

subtest 'Original issue regression test' => sub {
    my $highlighter = Syntax::Highlight::Engine::Kate::Perl->new(
        format_table => \%format_table
    );

    my $str = 'my $html = qq{<div class="%s">%s</div>};';
    my @warnings;

    local $SIG{__WARN__} = sub {
        push @warnings, $_[0];
    };

    my $highlighted;
    lives_ok {
        $highlighted = $highlighter->highlightText($str);
    } 'Original test case should not die';

    my @brace_warnings = grep { /Unescaped left brace in regex is deprecated/ } @warnings;
    is(scalar(@brace_warnings), 0, 'Original issue: no unescaped left brace warnings');

    is(scalar(@warnings), 0, 'No warnings of any kind')
        or diag "Unexpected warnings: $_" for @warnings;

    ok(length($highlighted) > 0, 'Got highlighted output');
};

subtest 'Summary: patch successfully removes warnings' => sub {
    my $highlighter = Syntax::Highlight::Engine::Kate::Perl->new(
        format_table => \%format_table
    );

    my @test_batch = (
        'qq{foo}',
        'qq{foo{bar}}',
        'qq{<tag>content</tag>}',
        'qq{${var} in string}',
        'qq{escaped \{ brace}',
    );

    my @all_warnings;
    local $SIG{__WARN__} = sub { push @all_warnings, @_ };

    for my $code (@test_batch) {
        $highlighter->highlightText("my \$str = $code;");
    }

    my @brace_warnings = grep { /Unescaped left brace in regex is deprecated/ } @all_warnings;
    is(scalar(@brace_warnings), 0, 'No brace deprecation warnings across all test cases');

    is(scalar(@all_warnings), 0, 'No warnings of any kind across all test cases')
        or diag "Total warnings: " . scalar(@all_warnings) . "\nFirst warning: $all_warnings[0]";
};

done_testing;

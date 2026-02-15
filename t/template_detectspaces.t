#!/usr/bin/ienv perl

use strict;
use warnings;
use Test::More;

use Syntax::Highlight::Engine::Kate::Perl;

my $plugin = Syntax::Highlight::Engine::Kate::Perl->new();
$plugin->engine($plugin);
$plugin->initialize();

# Test 1: Spaces at beginning with a valid context
my $text1     = "    hello world";
my $text_ref1 = \$text1;
my $result1   = $plugin->testDetectSpaces($text_ref1, 0, undef, undef, 'Normal-Text', 'Normal');
is($result1, 1, "Spaces: returns 1");
is($$text_ref1, "hello world", "Spaces: text modified correctly");

# Test 2: Tabs at beginning
my $text2     = "\t\thello world";
my $text_ref2 = \$text2;
my $result2   = $plugin->testDetectSpaces($text_ref2, 0, undef, undef, 'Normal-Text', 'Normal');
is($result2, 1, "Tabs: returns 1");
is($$text_ref2, "hello world", "Tabs: text modified correctly");

# Test 3: Mixed spaces and tabs
my $text3     = " \t \t hello world";
my $text_ref3 = \$text3;
my $result3   = $plugin->testDetectSpaces($text_ref3, 0, undef, undef, 'Normal-Text', 'Normal');
is($result3, 1, "Mixed: returns 1");
is($$text_ref3, "hello world", "Mixed: text modified correctly");

# Test 4: No whitespace
my $text4     = "hello world";
my $text_ref4 = \$text4;
my $result4   = $plugin->testDetectSpaces($text_ref4, 0, undef, undef, 'Normal-Text', 'Normal');
is($result4, '', "No whitespace: returns empty string");
is($$text_ref4, "hello world", "No whitespace: text unchanged");

# Test 5: Only spaces
my $text5     = "     ";
my $text_ref5 = \$text5;
my $result5   = $plugin->testDetectSpaces($text_ref5, 0, undef, undef, 'Normal-Text', 'Normal');
is($result5, 1, "Only spaces: returns 1");
is($$text_ref5, "", "Only spaces: text becomes empty");

# Test 6: Spaces with newline
my $text6     = "   \nhello";
my $text_ref6 = \$text6;
my $result6   = $plugin->testDetectSpaces($text_ref6, 0, undef, undef, 'Normal-Text', 'Normal');
is($result6, 1, "Spaces before newline: returns 1");
is($$text_ref6, "\nhello", "Spaces before newline: spaces removed");

# Test 7: Octal spaces
my $text7     = "\040\040\040hello";
my $text_ref7 = \$text7;
my $result7   = $plugin->testDetectSpaces($text_ref7, 0, undef, undef, 'Normal-Text', 'Normal');
is($result7, 1, "Octal spaces: returns 1");
is($$text_ref7, "hello", "Octal spaces: removed");

# Test 8: Newline only
my $text8     = "\nhello";
my $text_ref8 = \$text8;
my $result8   = $plugin->testDetectSpaces($text_ref8, 0, undef, undef, 'Normal-Text', 'Normal');
is($result8, '', "Newline only: returns empty string");
is($$text_ref8, "\nhello", "Newline only: text unchanged");

# Test 9: Empty string
my $text9     = "";
my $text_ref9 = \$text9;
my $result9   = $plugin->testDetectSpaces($text_ref9, 0, undef, undef, 'Normal-Text', 'Normal');
is($result9, '', "Empty string: returns empty string");
is($$text_ref9, "", "Empty string: unchanged");

# Test 10: With lookahead parameter
my $text10     = "   test";
my $text_ref10 = \$text10;
my $result10   = $plugin->testDetectSpaces($text_ref10, 1, undef, undef, 'Normal-Text', 'Normal');
is($result10, 1, "With lookahead: returns 1");
is($$text_ref10, "   test", "With lookahead: text NOT modified (lookahead mode)");

# Test 11: With column parameter - matching column
$plugin->linesegment("");      # Reset to beginning of line
my $text11     = "   test";
my $text_ref11 = \$text11;
my $result11   = $plugin->testDetectSpaces($text_ref11, 0, 0, undef, 'Normal-Text', 'Normal');
is($result11, 1, "With column=0 (matching): returns 1");
is($$text_ref11, "test", "With column=0: text modified");

# Test 12: With column parameter - non-matching column
$plugin->linesegment("");      # Reset
my $text12     = "   test";
my $text_ref12 = \$text12;
my $result12   = $plugin->testDetectSpaces($text_ref12, 0, 5, undef, 'Normal-Text', 'Normal');
is($result12, '', "With column=5 (non-matching): returns empty string");
is($$text_ref12, "   test", "With column=5: text unchanged");

# Test 13: With firstnonspace parameter
$plugin->linesegment("some");  # Line already has non-space content
my $text13     = "   test";
my $text_ref13 = \$text13;
my $result13   = $plugin->testDetectSpaces($text_ref13, 0, undef, 1, 'Normal-Text', 'Normal');
is($result13, '', "With firstnonspace and existing content: returns empty string");
is($$text_ref13, "   test", "With firstnonspace: text unchanged");

# Test 14: With firstnonspace parameter
$plugin->linesegment("");      # Line is empty
my $text14     = "   test";    # Next char is space
my $text_ref14 = \$text14;
my $result14   = $plugin->testDetectSpaces($text_ref14, 0, undef, 1, 'Normal-Text', 'Normal');
is($result14, '', "With firstnonspace, empty line, next char space: returns empty string");
is($$text_ref14, "   test", "With firstnonspace: text unchanged");

# Test 15: With firstnonspace parameter
$plugin->linesegment("");      # Line is empty
my $text15     = "test";       # Next char is non-space, but no leading spaces
my $text_ref15 = \$text15;
my $result15   = $plugin->testDetectSpaces($text_ref15, 0, undef, 1, 'Normal-Text', 'Normal');
is($result15, '', "With firstnonspace true but no spaces in text: returns empty string");
is($$text_ref15, "test", "With firstnonspace: text unchanged");

# Test 16: With firstnonspace parameter
$plugin->linesegment("   ");   # Line has only whitespace
my $text16     = "test";       # No leading spaces in remaining text
my $text_ref16 = \$text16;
my $result16   = $plugin->testDetectSpaces($text_ref16, 0, undef, 1, 'Normal-Text', 'Normal');
is($result16, '', "With firstnonspace true and no leading spaces: returns empty string");
is($$text_ref16, "test", "With firstnonspace: text unchanged");

# Test 17: With column and firstnonspace
$plugin->linesegment("");      # Line is empty
my $text17     = "   test";
my $text_ref17 = \$text17;
my $result17   = $plugin->testDetectSpaces($text_ref17, 0, 0, 1, 'Normal-Text', 'Normal');
is($result17, '', "With column=0 and firstnonspace false: returns empty string");
is($$text_ref17, "   test", "With column=0 and firstnonspace: text unchanged");

# Test 18: With column and firstnonspace
$plugin->linesegment("");      # Line is empty
my $text18     = "test";       # No leading spaces
my $text_ref18 = \$text18;
my $result18   = $plugin->testDetectSpaces($text_ref18, 0, 0, 1, 'Normal-Text', 'Normal');
is($result18, '', "With column=0 and firstnonspace true but no spaces: returns empty string");
is($$text_ref18, "test", "With column=0 and firstnonspace: text unchanged");

# Test 19: Without firstnonspace - normal operation
$plugin->linesegment("");      # Reset
my $text20     = "   test";
my $text_ref20 = \$text20;
my $result20   = $plugin->testDetectSpaces($text_ref20, 0, undef, undef, 'Normal-Text', 'Normal');
is($result20, 1, "Normal operation: returns 1");
is($$text_ref20, "test", "Normal operation: text modified");

# Test 20: Verify the regex matches both spaces and tabs
my $text21     = " \t \t test";
my $text_ref21 = \$text21;
my $result21   = $plugin->testDetectSpaces($text_ref21, 0, undef, undef, 'Normal-Text', 'Normal');
is($result21, 1, "Regex matches mixed spaces and tabs");
is($$text_ref21, "test", "Mixed spaces and tabs removed");

done_testing;

# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'c.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.25
#kate version 2.4
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::C;

our $VERSION = '0.06';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Alert' => 'Alert',
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'Prep. Lib' => 'Others',
      'Preprocessor' => 'Others',
      'Region Marker' => 'RegionMarker',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
   });
   $self->listAdd('keywords',
      'break',
      'case',
      'continue',
      'default',
      'do',
      'else',
      'enum',
      'extern',
      'for',
      'goto',
      'if',
      'inline',
      'return',
      'sizeof',
      'struct',
      'switch',
      'typedef',
      'union',
      'while',
   );
   $self->listAdd('types',
      '_Bool',
      '_Complex',
      '_Imaginary',
      'auto',
      'char',
      'const',
      'double',
      'float',
      'int',
      'long',
      'register',
      'restrict',
      'short',
      'signed',
      'static',
      'unsigned',
      'void',
      'volatile',
   );
   $self->contextdata({
      'Commentar 1' => {
         callback => \&parseCommentar1,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Commentar 2' => {
         callback => \&parseCommentar2,
         attribute => 'Comment',
      },
      'Commentar/Preprocessor' => {
         callback => \&parseCommentarPreprocessor,
         attribute => 'Comment',
      },
      'Define' => {
         callback => \&parseDefine,
         attribute => 'Preprocessor',
         lineending => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Outscoped' => {
         callback => \&parseOutscoped,
         attribute => 'Comment',
      },
      'Outscoped intern' => {
         callback => \&parseOutscopedintern,
         attribute => 'Comment',
      },
      'Preprocessor' => {
         callback => \&parsePreprocessor,
         attribute => 'Preprocessor',
         lineending => '#pop',
      },
      'Region Marker' => {
         callback => \&parseRegionMarker,
         attribute => 'Region Marker',
         lineending => '#pop',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'C';
}

sub parseCommentar1 {
   my ($self, $text) = @_;
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseCommentar2 {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseCommentarPreprocessor {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'Comment2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseDefine {
   my ($self, $text) = @_;
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '#\s*if\s+0'
   # attribute => 'Preprocessor'
   # beginRegion => 'Outscoped'
   # context => 'Outscoped'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*if\\s+0', 0, 0, 0, undef, 1, 'Outscoped', 'Preprocessor')) {
      return 1
   }
   # attribute => 'Preprocessor'
   # char => '#'
   # context => 'Preprocessor'
   # firstNonSpace => 'true'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 1, 'Preprocessor', 'Preprocessor')) {
      return 1
   }
   # String => '//BEGIN'
   # attribute => 'Region Marker'
   # beginRegion => 'Region1'
   # context => 'Region Marker'
   # firstNonSpace => 'true'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '//BEGIN', 0, 0, 0, undef, 1, 'Region Marker', 'Region Marker')) {
      return 1
   }
   # String => '//END'
   # attribute => 'Region Marker'
   # context => 'Region Marker'
   # endRegion => 'Region1'
   # firstNonSpace => 'true'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '//END', 0, 0, 0, undef, 1, 'Region Marker', 'Region Marker')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # attribute => 'Symbol'
   # beginRegion => 'Brace1'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # attribute => 'Symbol'
   # char => '}'
   # context => '#stay'
   # endRegion => 'Brace1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # items => 'ARRAY(0x12df8b0)'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      # String => 'fF'
      # attribute => 'Float'
      # context => '#stay'
      # type => 'AnyChar'
      if ($self->testAnyChar($text, 'fF', 0, 0, undef, 0, '#stay', 'Float')) {
         return 1
      }
   }
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'HlCOct'
   if ($self->testHlCOct($text, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # attribute => 'Hex'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'Hex')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # items => 'ARRAY(0x12207d0)'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      # String => 'ULL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'ULL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LUL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LUL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LLU'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LLU', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'UL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'UL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LU'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LU', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'U'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'U', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'L'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'L', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # context => '##Doxygen'
   # type => 'IncludeRules'
   if ($self->includePlugin('Doxygen', $text)) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Commentar 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   # String => ':!%&()+,-/.*<=>?[]|~^;'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ':!%&()+,-/.*<=>?[]|~^;', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parseOutscoped {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # context => '##Doxygen'
   # type => 'IncludeRules'
   if ($self->includePlugin('Doxygen', $text)) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Commentar 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   # String => '#\s*if'
   # attribute => 'Comment'
   # beginRegion => 'Outscoped'
   # context => 'Outscoped intern'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*if', 0, 0, 0, undef, 1, 'Outscoped intern', 'Comment')) {
      return 1
   }
   # String => '#\s*(endif|else|elif)'
   # attribute => 'Preprocessor'
   # context => '#pop'
   # endRegion => 'Outscoped'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*(endif|else|elif)', 0, 0, 0, undef, 1, '#pop', 'Preprocessor')) {
      return 1
   }
   return 0;
};

sub parseOutscopedintern {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # context => '##Doxygen'
   # type => 'IncludeRules'
   if ($self->includePlugin('Doxygen', $text)) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Commentar 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   # String => '#\s*if'
   # attribute => 'Comment'
   # beginRegion => 'Outscoped'
   # context => 'Outscoped intern'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*if', 0, 0, 0, undef, 1, 'Outscoped intern', 'Comment')) {
      return 1
   }
   # String => '#\s*endif'
   # attribute => 'Comment'
   # context => '#pop'
   # endRegion => 'Outscoped'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*endif', 0, 0, 0, undef, 1, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsePreprocessor {
   my ($self, $text) = @_;
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   # String => 'define.*((?=\\))'
   # attribute => 'Preprocessor'
   # context => 'Define'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'define.*((?=\\\\))', 0, 0, 0, undef, 0, 'Define', 'Preprocessor')) {
      return 1
   }
   # String => 'define.*'
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'define.*', 0, 0, 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   # attribute => 'Prep. Lib'
   # char => '"'
   # char1 => '"'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '"', '"', 0, 0, undef, 0, '#stay', 'Prep. Lib')) {
      return 1
   }
   # attribute => 'Prep. Lib'
   # char => '<'
   # char1 => '>'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '<', '>', 0, 0, undef, 0, '#stay', 'Prep. Lib')) {
      return 1
   }
   # context => '##Doxygen'
   # type => 'IncludeRules'
   if ($self->includePlugin('Doxygen', $text)) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment2'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar/Preprocessor'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar/Preprocessor', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseRegionMarker {
   my ($self, $text) = @_;
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::C - a Plugin for C syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::C;
 my $sh = new Syntax::Highlight::Engine::Kate::C([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::C is a  plugin module that provides syntax highlighting
for C to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author
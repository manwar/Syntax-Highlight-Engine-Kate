# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'logohighlightstyle.de_DE.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 0.2
#kate version 2.1
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::De_DE;

our $VERSION = '0.06';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Boolean Operators' => 'BString',
      'Comment' => 'Comment',
      'Execution Controllers' => 'BaseN',
      'Expressers' => 'Datatype',
      'MetaFunctions' => 'Function',
      'Normal' => 'Normal',
      'Normal Text' => 'Normal',
      'Number' => 'Float',
      'Operator' => 'Operator',
      'Raw String' => 'String',
      'Scopes' => 'RegionMarker',
      'Statements' => 'Keyword',
      'String' => 'String',
   });
   $self->listAdd('boolops',
      'nicht',
      'oder',
      'und',
   );
   $self->listAdd('controllers',
      'abbrechen',
      'bis',
      'f�rjedes',
      'in',
      'solange',
      'sonst',
      'tue',
      'von',
      'warte',
      'wdh',
      'wenn',
      'wiederhole',
      'zur�ck',
   );
   $self->listAdd('metafunctions',
      'lerne',
   );
   $self->listAdd('statements',
      'drucke',
      'dr�cke',
      'eingabefenster',
      'gehe',
      'gehex',
      'gehey',
      'gx',
      'gy',
      'indiemitte',
      'lauf',
      'ls',
      'l�sche',
      'nachlinks',
      'nachrechts',
      'nachricht',
      'nl',
      'nr',
      'papierfarbe',
      'papiergr��e',
      'pf',
      'pg',
      'richtung',
      'rtg',
      'rw',
      'r�ckw�rts',
      'schriftart',
      'schriftgr��e',
      'stbr',
      'stf',
      'sth',
      'stiftbreite',
      'stiftfarbe',
      'stifthoch',
      'stiftrunter',
      'str',
      'umbruchan',
      'umbruchaus',
      'verberge',
      'vg',
      'vorw�rts',
      'vw',
      'wc',
      'wechsle',
      'zeige',
      'zg',
      'zufall',
      'zur�cksetzen',
   );
   $self->contextdata({
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
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
   return 'de_DE';
}

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'metafunctions'
   # attribute => 'MetaFunctions'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'metafunctions', 0, undef, 0, '#stay', 'MetaFunctions')) {
      return 1
   }
   # String => 'statements'
   # attribute => 'Statements'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'statements', 0, undef, 0, '#stay', 'Statements')) {
      return 1
   }
   # String => 'controllers'
   # attribute => 'Execution Controllers'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'controllers', 0, undef, 0, '#stay', 'Execution Controllers')) {
      return 1
   }
   # String => 'boolops'
   # attribute => 'Boolean Operators'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'boolops', 0, undef, 0, '#stay', 'Boolean Operators')) {
      return 1
   }
   # String => '([!=><][=]|[><])'
   # attribute => 'Expressers'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([!=><][=]|[><])', 0, 0, 0, undef, 0, '#stay', 'Expressers')) {
      return 1
   }
   # String => '[a-zA-Z_][a-zA-Z_0-9]+'
   # attribute => 'Normal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z_][a-zA-Z_0-9]+', 0, 0, 0, undef, 0, '#stay', 'Normal')) {
      return 1
   }
   # String => '([0-9]+\.[0-9]*|\.[0-9]+)?|[0-9]*'
   # attribute => 'Number'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([0-9]+\\.[0-9]*|\\.[0-9]+)?|[0-9]*', 0, 0, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '[+*/\(\)-]'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[+*/\\(\\)-]', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '[\[\]]'
   # attribute => 'Scopes'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\[\\]]', 0, 0, 0, undef, 0, '#stay', 'Scopes')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => '%[a-zA-Z]'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%[a-zA-Z]', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
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

Syntax::Highlight::Engine::Kate::De_DE - a Plugin for de_DE syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::De_DE;
 my $sh = new Syntax::Highlight::Engine::Kate::De_DE([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::De_DE is a  plugin module that provides syntax highlighting
for de_DE to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author
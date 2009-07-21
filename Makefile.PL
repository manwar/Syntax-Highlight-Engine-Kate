use 5.006;
use inc::Module::Install 0.91;

name           'Syntax-Highlight-Engine-Kate';
license        'perl';
author         'Hans Jeuken';
all_from       'lib/Syntax/Highlight/Engine/Kate.pm';

requires       'perl'                     => '5.006';
test_requires  'Test::More'               => '0.88';

no_index       'directory'                => qw{ t xt eg share inc privinc };
homepage       'http://padre.perlide.org/';
#bugtracker     'http://padre.perlide.org/';
repository     'http://svn.perlide.org/padre/trunk/Syntax-Highlight-Engine-Kate/';

WriteAll;

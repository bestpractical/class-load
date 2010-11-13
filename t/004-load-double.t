use strict;
use warnings;

use Test::More tests => 2;
use Class::Load ':all';
use Test::Fatal;

use lib 't/lib';

# This test does 2 things.
# Firstly, confirm that on 5.8, load_class will
# still throw an exception , even if its been loaded before:
#
#    eval { require Foo; }; require Foo; # doesn't error on 5.8
#
# Secondly, to ensure errors thrown are useful.
# ( As without the code in load_class to delete $INC{file}
#    it will just die with "COMPILATION ERROR", which is
#    not useful )
#
like( exception {
    load_class('Class::Load::SyntaxError');
}, qr/syntax error/ );

like( exception {
    load_class('Class::Load::SyntaxError');
}, qr/syntax error/ );


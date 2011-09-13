#!/usr/bin/env perl
use strict;
use warnings;
use Test::More 0.88;
use Test::Fatal;

use lib 't/lib';
use Test::Class::Load 'load_optional_class';

isnt(
    exception {
        load_optional_class('Class::Load::Error::SyntaxErrorAfterIsa');
    },
    undef,
    'Class with a syntax error causes an error'
);

isnt(
    exception {
        load_optional_class('Class::Load::Error::SyntaxErrorAfterIsa');
    },
    undef,
    'Class with a syntax error causes an error (second attempt)'
);

done_testing;

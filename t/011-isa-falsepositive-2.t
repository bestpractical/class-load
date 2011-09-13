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
    'Loading a broken class breaks'
);

isnt(
    exception {
        load_optional_class('Class::Load::Error::SyntaxErrorAfterIsa');
    },
    undef,
    'Loading a broken class breaks(x2)'
);

done_testing;

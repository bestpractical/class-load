#!/usr/bin/env perl
use strict;
use warnings;
use Test::Fatal;
use Test::More 0.88;
use lib 't/lib';
use Test::Class::Load 'load_class';

like(
    exception { load_class('Foo:Bar') },
    qr/^Foo:Bar is not a module name/,
    "invalid module name"
);

done_testing;

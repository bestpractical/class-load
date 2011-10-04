#!/usr/bin/env perl
use strict;
use warnings;
use Test::Fatal;
use Test::More 0.88;
use lib 't/lib';
use Test::Class::Load 'load_class';

for my $badname ( 'Foo:Bar', '123', 'Foo::..::..::tmp::bad.pl',
    '::..::tmp::bad' ) {
    like(
        exception { load_class($badname) },
        qr/^$badname is not a module name/,
        "invalid module name"
    );
}

done_testing;

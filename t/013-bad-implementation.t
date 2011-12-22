#!/usr/bin/env perl
use strict;
use warnings;
use Test::More 0.88;
use Test::Fatal;

{
    no warnings 'once';
    $Class::Load::IMPLEMENTATION = 'Bad';
}

{
    like(
        exception { require Class::Load },
        qr/Can't locate Class.Load.Bad\.pm/,
        'error when loading Class::Load and we asked for a nonexistent implementation'
    );
}

done_testing();

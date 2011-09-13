#!/usr/bin/env perl
use strict;
use warnings;
use Test::More 0.88;
use Test::Fatal;

use lib 't/lib';
use Test::Class::Load 'load_optional_class';

isnt(
    exception {
        load_optional_class('Class::Load::Error::DieAfterIsa');
    },
    undef,
    'Class which calls die is reported as an error'
);

{
    local $TODO
        = q{I'm not sure this is fixable as it's really an interpreter issue.};

    isnt(
        exception {
            load_optional_class('Class::Load::Error::DieAfterIsa');
        },
        undef,
        'Class which calls die is reported as an error (second attempt)'
    );
}

done_testing;

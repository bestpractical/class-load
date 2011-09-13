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

isnt(
    exception {
        load_optional_class('Class::Load::Error::DieAfterIsa');
    },
    undef,
    'Class which calls die is reported as an error (second attempt)'
);

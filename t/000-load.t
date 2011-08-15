#!/usr/bin/env perl
use strict;
use warnings;
use Test::More 0.88;

use lib 't/lib';

use_ok 'Test::Class::Load';

diag('Using ' . Class::Load->_implementation() . ' implementation' );

done_testing;

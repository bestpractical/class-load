#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 2;

use Class::Require ':all';

ok(is_class_loaded('Class::Require'), "Class::Require is loaded");
ok(!is_class_loaded('Class::Require::NONEXISTENT'), "nonexistent class is NOT loaded");


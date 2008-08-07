#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 3;

use Class::Require 'is_class_loaded';

ok(is_class_loaded('Class::Require'), "Class::Require is loaded");

ok(!is_class_loaded('Class::Require::NONEXISTENT'), "nonexistent class is NOT loaded");

do {
    package Class::Require::WithISA;
    our @ISA = 'Class::Require';
};

ok(is_class_loaded('Class::Require::WithISA'), "class that defines \@ISA is loaded");


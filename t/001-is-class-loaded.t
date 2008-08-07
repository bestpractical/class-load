#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 6;

use Class::Require 'is_class_loaded';

ok(is_class_loaded('Class::Require'), "Class::Require is loaded");
ok(!is_class_loaded('Class::Require::NONEXISTENT'), "nonexistent class is NOT loaded");

do {
    package Class::Require::WithISA;
    our @ISA = 'Class::Require';
};
ok(is_class_loaded('Class::Require::WithISA'), "class that defines \@ISA is loaded");

do {
    package Class::Require::WithMethodISA;
    sub ISA { 'Class::Require' }
};
ok(is_class_loaded('Class::Require::WithMethodISA'), "class that defines a method ISA is loaded (no point in requiring it to be \@ISA)");

do {
    package Class::Require::WithVERSION;
    our $VERSION = '1.0';
};
ok(is_class_loaded('Class::Require::WithVERSION'), "class that defines \$VERSION is loaded");

do {
    package Class::Require::WithMethodVERSION;
    sub VERSION { '1.0' }
};
ok(is_class_loaded('Class::Require::WithMethodVERSION'), "class that defines a method VERSION is loaded (no point in requiring it to be \$VERSION)");


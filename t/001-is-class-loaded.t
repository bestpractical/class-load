#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 8;

use Class::Require 'is_class_loaded';

# basic {{{
ok(is_class_loaded('Class::Require'), "Class::Require is loaded");
ok(!is_class_loaded('Class::Require::NONEXISTENT'), "nonexistent class is NOT loaded");
# }}}

# @ISA (yes) {{{
do {
    package Class::Require::WithISA;
    our @ISA = 'Class::Require';
};
ok(is_class_loaded('Class::Require::WithISA'), "class that defines \@ISA is loaded");
# }}}
# $ISA (no) {{{
do {
    package Class::Require::WithScalarISA;
    our $ISA = 'Class::Require';
};
ok(!is_class_loaded('Class::Require::WithScalarISA'), "class that defines \$ISA is not loaded");
# }}}
# $VERSION (yes) {{{
do {
    package Class::Require::WithVERSION;
    our $VERSION = '1.0';
};
ok(is_class_loaded('Class::Require::WithVERSION'), "class that defines \$VERSION is loaded");
# }}}
# @VERSION (no) {{{
do {
    package Class::Require::WithArrayVERSION;
    our @VERSION = "1.0";
};
ok(!is_class_loaded('Class::Require::WithArrayVERSION'), "class that defines \@VERSION is not loaded");
# }}}
# method (yes) {{{
do {
    package Class::Require::WithMethod;
    sub foo { }
};
ok(is_class_loaded('Class::Require::WithMethod'), "class that defines any method is loaded");
# }}}
# global scalar (no) {{{
do {
    package Class::Require::WithScalar;
    our $FOO = 1;
};
ok(!is_class_loaded('Class::Require::WithScalar'), "class that defines just a scalar is not loaded");
# }}}


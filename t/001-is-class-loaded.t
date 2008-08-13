#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 11;

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
# $ISA (yes, sadly) {{{
do {
    package Class::Require::WithScalarISA;
    our $ISA = 'Class::Require';
};
ok(is_class_loaded('Class::Require::WithScalarISA'), "class that defines \$ISA is loaded");
# }}}
# $VERSION (yes) {{{
do {
    package Class::Require::WithVERSION;
    our $VERSION = '1.0';
};
ok(is_class_loaded('Class::Require::WithVERSION'), "class that defines \$VERSION is loaded");
# }}}
# @VERSION (yes, sadly) {{{
do {
    package Class::Require::WithArrayVERSION;
    our @VERSION = "1.0";
};
ok(is_class_loaded('Class::Require::WithArrayVERSION'), "class that defines \@VERSION is loaded");
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
# subpackage (no) {{{
do {
    package Class::Require::Foo::Bar;
    sub bar {}
};
ok(!is_class_loaded('Class::Require::Foo'), "even if Foo::Bar is loaded, Foo is not");
# }}}
# superstring (no) {{{
do {
    package Class::Require::Quuxquux;
    sub quux {}
};
ok(!is_class_loaded('Class::Require::Quux'), "Quuxquux does not imply the existence of Quux");
# }}}
# use constant (yes) {{{
do {
    package Class::Require::WithConstant;
    use constant PI => 3;
};
ok(is_class_loaded('Class::Require::WithConstant'), "defining a constant means the class is loaded");
# }}}


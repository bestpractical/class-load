#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 11;

use Class::Load 'is_class_loaded';

# basic {{{
ok(is_class_loaded('Class::Load'), "Class::Load is loaded");
ok(!is_class_loaded('Class::Load::NONEXISTENT'), "nonexistent class is NOT loaded");
# }}}

# @ISA (yes) {{{
do {
    package Class::Load::WithISA;
    our @ISA = 'Class::Load';
};
ok(is_class_loaded('Class::Load::WithISA'), "class that defines \@ISA is loaded");
# }}}
# $ISA (yes, sadly) {{{
do {
    package Class::Load::WithScalarISA;
    our $ISA = 'Class::Load';
};
ok(is_class_loaded('Class::Load::WithScalarISA'), "class that defines \$ISA is loaded");
# }}}
# $VERSION (yes) {{{
do {
    package Class::Load::WithVERSION;
    our $VERSION = '1.0';
};
ok(is_class_loaded('Class::Load::WithVERSION'), "class that defines \$VERSION is loaded");
# }}}
# @VERSION (yes, sadly) {{{
do {
    package Class::Load::WithArrayVERSION;
    our @VERSION = "1.0";
};
ok(is_class_loaded('Class::Load::WithArrayVERSION'), "class that defines \@VERSION is loaded");
# }}}
# method (yes) {{{
do {
    package Class::Load::WithMethod;
    sub foo { }
};
ok(is_class_loaded('Class::Load::WithMethod'), "class that defines any method is loaded");
# }}}
# global scalar (no) {{{
do {
    package Class::Load::WithScalar;
    our $FOO = 1;
};
ok(!is_class_loaded('Class::Load::WithScalar'), "class that defines just a scalar is not loaded");
# }}}
# subpackage (no) {{{
do {
    package Class::Load::Foo::Bar;
    sub bar {}
};
ok(!is_class_loaded('Class::Load::Foo'), "even if Foo::Bar is loaded, Foo is not");
# }}}
# superstring (no) {{{
do {
    package Class::Load::Quuxquux;
    sub quux {}
};
ok(!is_class_loaded('Class::Load::Quux'), "Quuxquux does not imply the existence of Quux");
# }}}
# use constant (yes) {{{
do {
    package Class::Load::WithConstant;
    use constant PI => 3;
};
ok(is_class_loaded('Class::Load::WithConstant'), "defining a constant means the class is loaded");
# }}}


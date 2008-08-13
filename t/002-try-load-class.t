#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 16;
use Class::Require ':all';
use lib 't/lib';

ok(try_load_class('Class::Require::OK'), "loaded class OK");
is($Class::Require::ERROR, undef);

ok(!try_load_class('Class::Require::Nonexistent'), "didn't load class Nonexistent");
like($Class::Require::ERROR, qr{^Can't locate Class/Require/Nonexistent.pm in \@INC});

ok(try_load_class('Class::Require::OK'), "loaded class OK");
is($Class::Require::ERROR, undef);

ok(!try_load_class('Class::Require::SyntaxError'), "didn't load class SyntaxError");
like($Class::Require::ERROR, qr{^Missing right curly or square bracket at });

ok(!try_load_class('Class::Require::Nonexistent'), "didn't load class Nonexistent");
like($Class::Require::ERROR, qr{^Can't locate Class/Require/Nonexistent.pm in \@INC});

ok(!try_load_class('Class::Require::SyntaxError'), "didn't load class SyntaxError");
like($Class::Require::ERROR, qr{^Missing right curly or square bracket at });

ok(is_class_loaded('Class::Require::OK'));
ok(!is_class_loaded('Class::Require::Nonexistent'));
ok(!is_class_loaded('Class::Require::SyntaxError'));

do {
    package Class::Require::Inlined;
    sub inlined { 1 }
};

ok(try_load_class('Class::Require::Inlined'), "loaded class Inlined");
is($Class::Require::ERROR, undef);
ok(is_class_loaded('Class::Require::Inlined'));


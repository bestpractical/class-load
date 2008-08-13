#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 14;
use Class::Load ':all';
use Test::Exception;
use lib 't/lib';

ok(load_class('Class::Load::OK'), "loaded class OK");
is($Class::Load::ERROR, undef);

throws_ok {
    load_class('Class::Load::Nonexistent')
} qr{^Can't locate Class/Load/Nonexistent.pm in \@INC};
like($Class::Load::ERROR, qr{^Can't locate Class/Load/Nonexistent.pm in \@INC});

ok(load_class('Class::Load::OK'), "loaded class OK");
is($Class::Load::ERROR, undef);

throws_ok {
    load_class('Class::Load::SyntaxError')
} qr{^Missing right curly or square bracket at };
like($Class::Load::ERROR, qr{^Missing right curly or square bracket at });

ok(is_class_loaded('Class::Load::OK'));
ok(!is_class_loaded('Class::Load::Nonexistent'));
ok(is_class_loaded('Class::Load::SyntaxError'));

do {
    package Class::Load::Inlined;
    sub inlined { 1 }
};

ok(load_class('Class::Load::Inlined'), "loaded class Inlined");
is($Class::Load::ERROR, undef);
ok(is_class_loaded('Class::Load::Inlined'));


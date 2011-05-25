#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 15;
use Class::Load ':all';
use Test::Fatal;
use lib 't/lib';

ok(load_class('Class::Load::OK'), "loaded class OK");
is($Class::Load::ERROR, undef);

like( exception {
    load_class('Class::Load::Nonexistent')
}, qr{^Can't locate Class/Load/Nonexistent.pm in \@INC});
like($Class::Load::ERROR, qr{^Can't locate Class/Load/Nonexistent.pm in \@INC});

ok(load_class('Class::Load::OK'), "loaded class OK");
is($Class::Load::ERROR, undef);

like( exception {
    load_class('Class::Load::SyntaxError')
}, qr{^Missing right curly or square bracket at });
like($Class::Load::ERROR, qr{^Missing right curly or square bracket at });

ok(is_class_loaded('Class::Load::OK'));
ok(!is_class_loaded('Class::Load::Nonexistent'));
ok(!is_class_loaded('Class::Load::SyntaxError'));

do {
    package Class::Load::Inlined;
    sub inlined { 1 }
};

ok(load_class('Class::Load::Inlined'), "loaded class Inlined");
is($Class::Load::ERROR, undef);
ok(is_class_loaded('Class::Load::Inlined'));

# line 999
eval { load_class('this_class_does_not_exists') };
my $load_class_error = $@;

# line 999
eval { require 'this_class_does_not_exists.pm' };
my $require_error = $@;

# This is needed because require() adds a full-stop at the end whereas
# croak() does not.
$require_error =~ s/\.$//;

is($load_class_error, $require_error, 'load_class() fails like require()');

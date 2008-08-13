#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 6;
use Class::Require 'try_load_class';
use lib 't/lib';

ok(try_load_class('Class::Require::OK'), "loaded class OK");
is($Class::Require::ERROR, undef);

ok(!try_load_class('Class::Require::Nonexistent'), "didn't load class Nonexistent");
like($Class::Require::ERROR, qr{^Can't locate Class/Require/Nonexistent.pm in \@INC});

ok(try_load_class('Class::Require::OK'), "loaded class OK");
is($Class::Require::ERROR, undef);


#!/usr/bin/env perl
package Class::Require;
use strict;
use warnings;
use base 'Exporter';

our @EXPORT_OK = qw/load_class try_load_class is_class_loaded/;
our %EXPORT_TAGS = (
    all => \@EXPORT_OK,
);

sub load_class {
    my $class = shift;

}

sub try_load_class {
    my $class = shift;

}

sub is_class_loaded {
    my $class = shift;

}

1;


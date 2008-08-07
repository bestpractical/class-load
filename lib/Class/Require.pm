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

    # is the module's file in %INC?
    my $file = (join '/', split '::', $class) . '.pm';
    return 1 if $INC{$file};

    # any interesting symbols in this module's symbol table?
    my $table = do {
        no strict 'refs';
        \%{ $class . '::' };
    };

    # ..such as @ISA?
    return 1 if exists $table->{ISA};

    # ..such as $VERSION?
    return 1 if exists $table->{VERSION};

    for my $glob (values %$table) {
        return 1 if *{$glob}{CODE};
    }

    return 0;
}

1;


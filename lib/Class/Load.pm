#!/usr/bin/env perl
package Class::Load;
use strict;
use warnings;
use base 'Exporter';
use File::Spec;

our $VERSION = '0.02';

our @EXPORT_OK = qw/load_class try_load_class is_class_loaded/;
our %EXPORT_TAGS = (
    all => \@EXPORT_OK,
);

our $ERROR;

sub load_class {
    my $class = shift;

    return 1 if try_load_class($class);

    require Carp;
    Carp::croak $ERROR;
}

sub try_load_class {
    my $class = shift;

    undef $ERROR;

    return 1 if is_class_loaded($class);

    # see rt.perl.org #19213
    my @parts = split '::', $class;
    my $file = $^O eq 'MSWin32'
             ? join '/', @parts
             : File::Spec->catfile(@parts);
    $file .= '.pm';

    return 1 if eval {
        local $SIG{__DIE__} = 'DEFAULT';
        require $file;
        1;
    };

    $ERROR = $@;
    return 0;
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

    # ..or a method?
    for my $glob (values %$table) {
        return 1 if *{$glob}{CODE};
    }

    return 0;
}

1;

__END__

=head1 NAME

Class::Load - a working (require "Class::Name") and more

=head1 SYNOPSIS

    use Class::Load ':all';

    try_load_class('Class::Name')
        or plan skip_all => "Class::Name required to run these tests";

    load_class('Class::Name');

    is_class_loaded('Class::Name');

=head1 DESCRIPTION

C<require EXPR> only accepts C<Class/Name.pm> style module names, not
C<Class::Name>. How frustrating!

It's often useful to test whether a module can be loaded, instead of throwing
an error when it's not available.

Finally, sometimes we need to know whether a particular class has been loaded.
Asking C<%INC> is an option, but that will miss inner packages and any class
for which the filename does not correspond to the package name.

=head1 FUNCTIONS

=head2 load_class Class::Name

C<load_class> will load C<Class::Name> or throw an error, much like C<require>.

If C<Class::Name> is already loaded (checked with C<is_class_loaded>) then it
will not try to load the class. This is useful when you have inner packages
which C<require> does not check.

=head2 try_load_class Class::Name -> 0|1

Returns 1 if the class was loaded, 0 if it was not. If the class was not
loaded, the error will be available in C<$Class::Load::ERROR>.

Again, if C<Class::Name> is already loaded (checked with C<is_class_loaded>)
then it will not try to load the class. This is useful when you have inner
packages which C<require> does not check.

=head2 is_class_loaded Class::Name -> 0|1

This uses a number of heuristics to determine if the class C<Class::Name> is
loaded. We check first whether it has an entry in C<%INC>, then check its
symbol table for interesting values.

=head1 SEE ALSO

=over 4

=item L<UNIVERSAL::require>

Adds a C<require> method to C<UNIVERSAL> so that you can say
C<< Class::Name->require >>. I personally dislike the pollution.

=item L<Module::Load>

Supports C<Class::Name> and C<< Class/Name.pm >> formats, no C<try_to_load> or
C<is_class_loaded>.

=item L<Moose>, L<Jifty>, L<Prophet>, etc

This module was designed to be used anywhere you have
C<if (eval "require $module"; 1)>.

=back

=head1 AUTHOR

Shawn M Moore, C<< <sartak at bestpractical.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-class-load at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Class-Load>.

=head1 COPYRIGHT & LICENSE

Copyright 2008 Best Practical Solutions.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut


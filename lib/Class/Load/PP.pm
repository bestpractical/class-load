package Class::Load::PP;

use strict;
use warnings;
use Scalar::Util 'reftype';

BEGIN {
    *IS_RUNNING_ON_5_10 = ($] < 5.009_005)
        ? sub () { 0 }
        : sub () { 1 };
}

sub is_class_loaded {
    my $class   = shift;
    my $options = shift;

    my $loaded = _is_class_loaded($class);

    return $loaded if ! $loaded;
    return $loaded unless $options && $options->{-version};

    return eval {
        $class->VERSION($options->{-version});
        1;
    } ? 1 : 0;
}

sub _is_class_loaded {
    my $class = shift;

    return 0 unless Class::Load::_is_valid_class_name($class);

    # walk the symbol table tree to avoid autovififying
    # \*{${main::}{"Foo::"}} == \*main::Foo::

    my $pack = \*::;
    foreach my $part (split('::', $class)) {
        return 0 unless exists ${$$pack}{"${part}::"};
        $pack = \*{${$$pack}{"${part}::"}};
    }

    # We used to check in the package stash, but it turns out that
    # *{${$$package}{VERSION}{SCALAR}} can end up pointing to a
    # reference to undef. It looks

    my $version = do {
        no strict 'refs';
        ${$class . '::VERSION'};
    };

    return 1 if ! ref $version && defined $version;
    # Sometimes $VERSION ends up as a reference to undef (weird)
    return 1 if ref $version && reftype $version eq 'SCALAR' && defined ${$version};

    return 1 if exists ${$$pack}{ISA}
             && defined *{${$$pack}{ISA}}{ARRAY};

    # check for any method
    foreach ( keys %{$$pack} ) {
        next if substr($_, -2, 2) eq '::';

        my $glob = ${$$pack}{$_} || next;

        # constant subs
        if ( IS_RUNNING_ON_5_10 ) {
            my $ref = ref($glob);
            return 1 if $ref eq 'SCALAR' || $ref eq 'REF';
        }

        # stubs
        my $refref = ref(\$glob);
        return 1 if $refref eq 'SCALAR';

        return 1 if defined *{$glob}{CODE};
    }

    # fail
    return 0;
}

1;

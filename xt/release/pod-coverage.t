#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

use Test::Requires {
    'Test::Pod::Coverage' => '1.04',
};

my @modules = 'Class::Load';

my %trustme;

for my $module ( sort @modules ) {
    my $trustme = [];

    if ( $trustme{$module} ) {
        if ( ref $trustme{$module} eq 'ARRAY' ) {
            my $methods = join '|', @{ $trustme{$module} };
            $trustme = [qr/^(?:$methods)$/];
        }
        else {
            $trustme = [ $trustme{$module} ];
        }
    }

    pod_coverage_ok(
        $module,
        {
            trustme => $trustme,
        },
        "Pod coverage for $module"
    );
}

done_testing();

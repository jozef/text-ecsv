#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
#use Test::More tests => 10;

#use FindBin qw($Bin);
#use lib "$Bin/lib";

BEGIN {
    use_ok ( 'Text::ECSV' ) or exit;
}

exit main();

sub main {
    my $ecsv = Text::ECSV->new();
    isa_ok($ecsv, 'Text::CSV_XS');
    
    ok($ecsv->parse('a=1,b=2,c=3'), 'parse line');

    is_deeply(
        $ecsv->fields_hash,
        {
            'b' => 2,
            'c' => 3,
            'a' => 1,
        },
        'line should be decoded to hash'
    );
    
    is_deeply(
        [
            $ecsv->field_named('c'),
            $ecsv->field_named('b'),
            $ecsv->field_named('a'),
        ],
        [ 3, 2, 1],
        'check value of fields using field_named()',
    );

    ok($ecsv->parse('whatever= 1 == 0.5+0.5,"F=ma2",E=E=mc2=E'), 'parse another line');

    is_deeply(
        [
            $ecsv->field_named('whatever'),
            $ecsv->field_named('F'),
            $ecsv->field_named('E'),
            $ecsv->field_named('a'),
        ],
        [ ' 1 == 0.5+0.5', 'ma2', 'E=mc2=E', undef ],
        'check value of fields having = using field_named()',
    );
    
    return 0;
}


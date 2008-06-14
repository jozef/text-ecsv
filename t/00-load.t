#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Text::ECSV' );
}

diag( "Testing Text::ECSV $Text::ECSV::VERSION, Perl $], $^X" );

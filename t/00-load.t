#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Raspi::ShiftOut' ) || print "Bail out!\n";
}

diag( "Testing Raspi::ShiftOut $Raspi::ShiftOut::VERSION, Perl $], $^X" );

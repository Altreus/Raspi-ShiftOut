package Raspi::ShiftOut;

use 5.006;
use strict;
use warnings;

use Device::BCM2835;

=head1 NAME

Raspi::ShiftOut - Send bits to a shift register

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 DESCRIPTION

A shift register implementation similar to shiftOut in the Arduino SDK. Main
differences are the function name is Perlified (underscores) and the input can
be any length of binary data.

=head1 SYNOPSIS

    use Raspi::ShiftOut;

    shift_out(Device::BCM2835::RPI_GPIO_R1_11, Device::BCM2835::RPI_GPIO_R1_12,
        Raspi::ShiftOut::MSBFIRST, $int);

=head1 EXPORT

=head2 shift_out

shift_out is exported by default (overridden by passing an empty import list in
the usual way);

=head2 MSBFIRST, LSBFIRST

Specify these symbols to export them. They are always available as
C<Raspi::ShiftOut::{M,L}SBFIRST>.

=head2 :bit_order

Exports both C<MSBFIRST> and C<LSBFIRST>

=head2 :all

Exports all the things.

=head1 SUBROUTINES/METHODS

=head2 shift_out($data_pin, $clock_pin, $bit_order, $data)

=cut

sub shift_out {
    my ($data_pin, $clock_pin, $bit_order, $data) = @_;
}

=head1 AUTHOR

Altreus, C<< <altreus at cpan.org> >>

=head1 BUGS

Report bugs at Github: L<http://github.com/Altreus/Raspi-ShiftOut>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Altreus.

This program is free software; you can redistribute it and/or modify it
under the terms of the MIT/X11 Licence

See http://opensource.org/licenses/mit-license.php for more information.

Yes, that's a PHP page.

=cut

1;

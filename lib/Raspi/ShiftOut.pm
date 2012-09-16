package Raspi::ShiftOut;

use 5.006;
use strict;
use warnings;

use Device::BCM2835;

use constant MSBFIRST => 0;
use constant LSBFIRST => 1;

use constant BIGENDIAN => 0;
use constant LITTLEENDIAN => 1;

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

These determine the bit order of the data. You have to specify these symbols to
export them. They are always available as C<Raspi::ShiftOut::{M,L}SBFIRST>. 

=head2 :bit_order

Exports both C<MSBFIRST> and C<LSBFIRST>

=head2 BIGENDIAN, LITTLEENDIAN

These determine the byte order of the data. You have to specify these symbols to
export them. They are always available as C<Raspi::ShiftOut::{BIG,LITTLE}ENDIAN>. 

=head2 :byte_order

Exports both C<BIGENDIAN> and C<LITTLEENDIAN>

=head2 :all

Exports all the things.

=head1 SUBROUTINES

=head2 shift_out($data_pin, $clock_pin, $bit_order, $data[, $bytes, [$byte_order]])

Outputs C<$data> as a sequence of C<$bytes> bytes of binary data. The first byte
will go out first, unless C<$byte_order> is C<LITTLEENDIAN>, when it will go last.

If the C<$bit_order> is C<LSBFIRST>, the bits in each byte will be reversed.

The C<$data_pin> and C<$clock_pin> accept anything from Device::BCM2835 that can
be given to L<<C<gpio_write>|Device::BCM2835>>.

C<$bytes> defaults to 1, and C<$byte_order> defaults to C<BIGENDIAN>.

=cut

sub shift_out {
    my ($data_pin, $clock_pin, $bit_order, $data, $bytes, $endian) = @_;

    $bytes ||= 1;
    $endian ||= BIGENDIAN;

    my $binary = sprintf "%0${$bytes*8}b", $data;

    for ($endian == BIGENDIAN ? 0 .. $bytes : reverse 0 .. $bytes) {
        my $byte = substr $binary, $_ * 8, 8;

        $byte = reverse $byte if $bit_order == LSBFIRST;

        for my $bit (split //, $byte) {
            Device::BCM2835::gpio_write($data_pin, $bit);
            Device::BCM2835::gpio_write($clock_pin, 1);
            Device::BCM2835::gpio_write($clock_pin, 1);
        }
    }
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

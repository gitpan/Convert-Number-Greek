package Convert::Number::Greek;

require 5.008;
use strict;   # :-(
use warnings; # :-(
use POSIX 'floor';
use utf8;
require Exporter;


=head1 NAME

Convert::Number::Greek - Convert between Arabic and Greek numerals

=cut


use vars qw[
	@ISA
	@EXPORT_OK
	$VERSION
	@greek_digits
	@greek_digits_uc
];

$VERSION   = 0.01;
@ISA       = 'Exporter';
@EXPORT_OK = qw'num2greek greek2num';


=head1 VERSION

This document describes version .01 of this module, hastily released
on 16 August, 2006.

=head1 SYNOPSIS

  use Convert::Number::Greek 'num2greek';
  
  $greek_number = num2greek 1996;
  # $greek_number now contains a Unicode string.

  # OR
  
  use Convert::Number::Greek;
  
  $greek_number = Convert::Number::Greek::num2greek 1996;
  
=head1 DESCRIPTION

This module provides one exportable subroutine, C<num2greek>, which
converts an Arabic numeral to a Greek numeral in the 
form of a Unicode string. The syntax is as follows:

=over 4

=item num2greek ( NUMBER, { OPTIONS } )

NUMBER is the number to convert. It should be a string of digits,
nothing more (see L<BUGS>, below). OPTIONS (optional) is a reference
to a hash of boolean options. The options available are as follows:
   
 Option Name    Default Value   Description
 upper          0               Use uppercase Greek letters
 uc             0                "      "       "      "
 stigma         1               Use the stigma for 6 as opposed to
                                sigma followed by tau
 arch_koppa     0               Use the archaic koppa instead of
                                the modern one
 numbersign     1               Append a Greek number sign (U+0374)
                                to the resulting string
	 
When you specify options, C<undef> is treated as false, so
   
    num2greek $some_number, { uc => 1, stigma }

actually means

    num2greek $some_number, { uc => 1, stigma => 0 }

=back

=cut
   


@greek_digits = (
	['', qw[α β γ δ ε ϛ ζ η θ]],
	['', qw[ι κ λ μ ν ξ ο π ϟ]],
	['', qw[ρ σ τ υ φ χ ψ ω ϡ]],
);
@greek_digits_uc = (
	['', qw[Α Β Γ Δ Ε Ϛ Ζ Η Θ]],
	['', qw[Ι Κ Λ Μ Ν Ξ Ο Π Ϟ]],
	['', qw[Ρ Σ Τ Υ Φ Χ Ψ Ω Ϡ]],
);

sub num2greek ($;$) {
	my ($n, $options) = @_;
	my $ret;

	$options ||= {};

	my @digits = $$options{uc} || $$options{upper} ? @greek_digits_uc : @greek_digits;
	
	exists $$options{stigma} and !$$options{stigma} and
		local $digits[0][6] = $digits[0][6] eq 'ϛ' ? 'στ' : 'ΣΤ';
	$$options{arch_koppa} and
		local $digits[1][9] = $digits[1][9] eq 'ϟ' ? 'ϙ' : 'Ϙ';
	
	for my $place ( reverse 0 .. length($n) - 1 ) {
		my $digit = substr $n, length($n) - $place - 1, 1;
		
		$ret .= '͵' x floor($place / 3) . # thousands indicator
			$digits[$place % 3][$digit];
			
	}
	$ret .= 'ʹ' unless exists $$options{numbersign} and !$$options{numbersign};
	$ret;
}

#sub greek2num {
#
#}

=pod

The C<greek2num> function for parsing Greek numbers has yet to be
written....

An object-oriented interface similar to that of
S<C<Convert::Number::Roman>> will be implemented some day.

=head1 COMPATIBILITY

This module has only been tested in perl 5.8.6 on Darwin. It
definitely will I<not> work with perl versions earlier than 5.8.0.

=head1 BUGS

The C<num2greek> function does not yet have any error-checking
mechanism in place. The input should be a string of Arabic digits, or
at least a value that stringifies to such. Using an argument that does
not fit this description may produce nonsensical results.

=head1 AUTHOR

Father Chrysostomos <sprout @cpan.org>

=cut





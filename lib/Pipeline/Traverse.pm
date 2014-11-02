use strict;
use warnings;

package Pipeline::Traverse;

use Exporter 'import';
our @EXPORT_OK = qw(fetch at hashref arrayref deref);

sub fetch { my ($key) = @_; sub { my %hash = deref(@_); deref($hash{$key}) } }

sub at { my ($index) = @_; sub { my @array = deref(@_); deref($array[$index]) } }

sub hashref { my %hash = @_; \%hash }

sub arrayref { my @array = @_; \@array }

sub deref {
  my $ref = ref $_[0];
  my $single = scalar(@_) eq 1;

  if    ( $ref eq 'ARRAY' && $single ) { @{ $_[0] }; }
  elsif ( $ref eq 'HASH' && $single )  { %{ $_[0] }; }
  else                                 { @_; }
}

1;
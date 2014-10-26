use strict;
use warnings;

package Traverse;

use Exporter 'import';
our @EXPORT_OK = qw(fetch at);

sub fetch { my ($key) = @_; sub { my %hash = deref(@_); deref($hash{$key}) } }

sub at { my ($index) = @_; sub { my @array = deref(@_); deref($array[$index]) } }

sub deref {
  my $ref = ref $_[0];
  my $single = scalar(@_) eq 1;

  if    ( $ref eq 'ARRAY' && $single ) { @{ $_[0] }; }
  elsif ( $ref eq 'HASH' && $single )  { %{ $_[0] }; }
  else                                 { @_; }
}

1;
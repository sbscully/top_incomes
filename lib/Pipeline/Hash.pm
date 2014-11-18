use strict;
use warnings;

package Pipeline::Hash;

use List::Util qw(all);

use Exporter 'import';
our @EXPORT_OK = qw(contains where where_defined pluck);

sub contains {
  my $hashref = shift;
  my %opts = @_;

  all { defined $hashref->{$_} && ($hashref->{$_} eq $opts{$_})  } keys %opts
}

sub where {
  my $opts = shift;
  my @array = @_;

  grep { contains($_, %$opts) } @array
}

sub where_defined {
  my $key = shift;

  grep { defined $_->{$key} } @_
}

sub pluck {
  my $key = shift;
  my @array = @_;

  map { $_->{$key} } @array
}

1;
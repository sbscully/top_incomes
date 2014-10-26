use strict;
use warnings;

package Matrix;

use Exporter 'import';
our @EXPORT_OK = qw(transpose);

sub transpose {
  my $data = \@_;
  my $transposed = [];

  foreach my $i ( (0..scalar(@$data)-1) ) {
    foreach my $j ( (0..scalar(@{ $data->[1] })-1) ) {
      $transposed->[$j] //= [];
      $transposed->[$j][$i] = $data->[$i][$j];
    }
  }

  return @$transposed;
}

1;
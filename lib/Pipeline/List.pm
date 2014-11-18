use strict;
use warnings;

package Pipeline::List;

use List::Util qw(max);

use Exporter 'import';
our @EXPORT_OK = qw(concat flatten zip_refs transpose zip_refs_compact);

sub concat { my @array = @_; chomp(@array); join "\n", @array; }

sub flatten { map { @$_ } @_ }

sub zip_refs {
  my $max = -1;
  ($max < $#$_) && ($max = $#$_) for @_;

  map { my $ix = $_; [ map $_->[$ix], @_ ] } 0..$max
}
*transpose = \&zip_refs;

sub zip_refs_compact { grep { !grep { !defined } @$_ } zip_refs(@_) }

1;
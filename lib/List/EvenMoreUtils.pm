use strict;
use warnings;

package List::EvenMoreUtils;

use Pipeline;
use List::Util qw(max);

use Exporter 'import';
our @EXPORT_OK = qw(zip_refs transpose zip_refs_compact);

sub zip_refs {
  my @refs = @_;
  my $length = max map { scalar @$_ } @refs;

  map { my $index = $_; [ map { $_->[$index] } @refs ] } (0 .. $length)
}
*transpose = \&zip_refs;

sub zip_refs_compact { pipeline @_, qw(zip_refs compact_zipped flatten_zipped) }

sub compact_zipped { grep { !grep { !defined } @$_ } @_ }

sub flatten_zipped { map { @$_ } @_ }

1;
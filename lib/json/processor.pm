use strict;
use warnings;

package JSON::Processor;

use Pipeline;
use JSON::XS;

use Exporter 'import';
our @EXPORT = qw(process_json);

sub process_json (&@) {
  my $sub = shift;
  pipeline(@_, 'decode_json', $sub, 'pretty_encode_json')
}

sub pretty_encode_json { JSON::XS->new->utf8->pretty(1)->encode(@_) }

1;
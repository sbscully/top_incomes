use strict;
use warnings;

package Pipeline;

use Exporter 'import';
our @EXPORT = qw(compose pipeline);

sub compose {
  my $g = pop;
  my $f = pop;
  my @subs = @_;

  if ( @subs ) {
    sub { $g->( compose(@subs, $f)->(@_) ) }
  }
  else {
    sub { $g->($f->(@_)) };
  }
}

sub pipeline (+@) {
  my ($args, @subs) = @_;

  @subs = map { bind_ref($_, caller) } @subs;

  compose(@subs)->(@$args)
}

sub bind_ref {
  my ($sub, @caller) = @_;
  return $sub if ref $sub eq 'CODE';

  my $package = shift @caller;
  my $name = $package . '::' . $_;

  \&$name
}

1;
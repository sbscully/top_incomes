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
  my ($sub, $package) = @_;

  if (ref $sub eq 'CODE') {
    $sub
  }
  else {
    $sub = join '::', $package, $sub;
    \&$sub
  }
}

1;
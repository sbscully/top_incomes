use strict;
use warnings;

package Pipeline;

use Exporter 'import';
our @EXPORT = qw(compose pipeline curry apply);

sub compose {
  my $g = pop;
  my $f = pop;
  my @subs = @_;

  die 'two or more code references required' unless $f;

  if ( @subs ) {
    sub { $g->( compose(@subs, $f)->(@_) ) }
  }
  else {
    sub { $g->($f->(@_)) };
  }
}

sub pipeline (+@) {
  my ($args, @subs) = @_;

  $args = ref $args eq 'ARRAY' ? $args : [ $args ];
  @subs = map { bind_ref($_, caller) } @subs;

  compose(@subs)->(@$args)
}

sub curry {
  my ($sub, @args) = @_;

  $sub = bind_ref($sub, caller);

  sub { $sub->(@args, @_) }
}

sub apply {
  my ($sub, @args) = @_;

  $sub = bind_ref($sub, caller);

  sub { $sub->(@_, @args) }
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
use strict;
use warnings;

package Chain;

use Exporter 'import';
our @EXPORT = qw(chain);

sub chain { Chain::Object->_new(@_) }

package Chain::Object {
  sub _new {
    my $class = shift;
    my $object = shift;

    bless { object => $object }, $class;
  }

  sub new {
    my $self = shift;

    $self->{object} = $self->{object}->new(@_);
    $self
  }

  sub value {
    my $self = shift;

    $self->{object}
  }

  our $AUTOLOAD;
  sub AUTOLOAD {
    my $self = shift;
    my $name = (split '::', $AUTOLOAD)[-1];

    $self->{object}->$name(@_);
    $self
  }
}

1;
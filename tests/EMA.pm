package EMA;
use strict;

sub new {
    my($proto, $length) = @_;
    return bless({}, ref($proto) || $proto);
}

1;
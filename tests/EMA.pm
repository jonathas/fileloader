#!/usr/bin/perl

package EMA;
use strict;

sub new {
    my($proto, $length) = @_;
    return bless({}, ref($proto) || $proto);
}

#use Test::More tests => 2;
#BEGIN {
#    use_ok('EMA');
#    ok(EMA->new(3));
#}

1;
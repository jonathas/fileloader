#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::RealBin/db";
use DBConnection;

package Distro;

my $dbh;

sub new {
	my $class = shift;
	my $self = {};
	$dbh = DBConnection->new();
	bless $self, $class;
    return $self;
}

sub add {
	my ( $self, @firstName ) = @_;
    #$self->{_firstName} = $firstName if defined($firstName);
    return @firstName;
}

1;
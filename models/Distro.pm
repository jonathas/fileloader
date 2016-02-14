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
	my ( $self, @distroData ) = @_;
    my $query = "INSERT INTO distros (id, name, date, update_timestamp) VALUES ('$distroData[0]', '$distroData[1]', '$distroData[2]', NOW())";
    return $dbh->execute($query);
}

1;
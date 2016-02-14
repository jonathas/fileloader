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

sub save {
	# TODO:
	# - Implement this method to use add or update
	# - If there already exists record in DB with given ID, that record is updated with information from file and Update_timestamp is set to system current timestamp.
	# - If new record is detected in file, new record is created in DB with attributes from file and Update_timestamp is set to system current timestamp.
	# - If any update is detected, record in DB is updated and Update_timestamp is set to system current timestamp.
	# - If record does not exist in the file, no action is taken.
	
}

sub add {
	my ( $self, @distroData ) = @_;
    my $query = "INSERT INTO distros (id, name, date, update_timestamp) VALUES ('$distroData[0]', '$distroData[1]', '$distroData[2]', NOW())";
    return $dbh->execute($query);
}

sub update {
	my ( $self, $id, @distroData ) = @_;
    my $query = "UPDATE distros SET id = '$id', name = '$distroData[1]', date = '$distroData[2]', update_timestamp = NOW() WHERE id = $id";
    return $dbh->execute($query);
}

1;
#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::RealBin/db";
use DBConnection;

package Distro;

my $tableName = "distros";
my $dbh;

sub new {
	my $class = shift;
	my $self = {};
	$dbh = DBConnection->new();
	bless $self, $class;
    return $self;
}

sub save {	
	my ( $self, @distroData ) = @_;
	if($dbh->isRecord($tableName, $distroData[0])) {
		update($distroData[0], @distroData);
		return "[UPDATE]";
	} else {
		insert(@distroData);
		return "[INSERT]";
	}
}

sub insert {
	my ( $self, @distroData ) = @_;
    my $query = "INSERT INTO $tableName (id, name, date, update_timestamp) VALUES ('$distroData[0]', '$distroData[1]', '$distroData[2]', NOW())";
    return $dbh->execute($query);
}

sub update {
	my ( $self, $id, @distroData ) = @_;
    my $query = "UPDATE $tableName SET id = '$id', name = '$distroData[0]', date = '$distroData[1]', update_timestamp = NOW() WHERE id = '$id'";
    return $dbh->execute($query);
}

1;
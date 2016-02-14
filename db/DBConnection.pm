#!/usr/bin/perl

use strict;
use warnings;

use DBI;
use XML::Simple;
$XML::Simple::PREFERRED_PARSER = 'XML::Parser';
use Data::Dumper;

package DBConnection;

my $xml;
my $data;
my $password = "";
my $dbh;

sub new {
	my $class = shift;
	my $self = {};
	readDBConfig();
	openConnection();
	bless $self, $class;
    return $self;
}

sub readDBConfig {
	$xml = new XML::Simple;

	$data = $xml->XMLin("db/database.xml");
	
	#Avoid using the hash that represents an empty password
	if (!( ref $data->{password} && eval { keys %{ $data->{password} } == 0 } )) {
	    $password = $data->{password};
	}
}

sub openConnection {
	$dbh = DBI->connect("dbi:mysql:dbname=$data->{dbname};host=$data->{host}", $data->{user}, $password,                          
    { RaiseError => 1 }, ) or die $DBI::errstr;
}

sub execute {
	my ( $self, $query ) = @_;
    return $dbh->do($query);
}

sub closeConnection {
	$dbh->disconnect();
}

sub doSomething {
	my $sth = $dbh->prepare("SELECT VERSION()");
	$sth->execute();
	my $ver = $sth->fetch();
	print @$ver;
	print "\n";
	$sth->finish();
}

1;
#!/usr/bin/perl

use strict;
use warnings;

# Using a perl module from a custom directory
use FindBin;
use lib "$FindBin::RealBin/models";

use Distro;
use Data::Dumper;

$|=1;

sub main {
	# Exit unless we have the correct number of command-line args
	my $num_args = $#ARGV + 1;
	if ($num_args != 2) {
	    print "\nUsage: fileloader.pl path file_mask\nExample: path = /var/loader_files\n \t file_mask = headers.tsv\n";
	    exit;
	}
	 
	my $filepath = "$ARGV[0]/$ARGV[1]";
	my @line; 
	
	open(my $fh, '<:encoding(UTF-8)', $filepath) or die "Could not open file '$filepath' $!";
 
	my $distro = new Distro();
 
	while (my $row = <$fh>) {
	  chomp $row;
	  
	  @line = split /\t/, $row;
	  
	  # Jump the header
	  if ($line[0] eq "ID") {
	  	next;
	  }
	  
	  $distro->add(@line);
	}

}

main();
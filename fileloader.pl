#!/usr/bin/perl

use strict;
use warnings;

# Using a perl module from a custom directory
use FindBin;
use lib "$FindBin::RealBin/classes";

use FileHandler;

$|=1;

sub main {
	print "FileLoader\n\n";
	
	# Exit unless we have the correct number of command-line args
	my $num_args = $#ARGV + 1;
	if ($num_args != 2) {
	    print "Usage: fileloader.pl path file_mask\nExample: fileloader.pl /var/loader_files headers.tsv\n";
	    exit;
	}
	 	
	my $fh = new FileHandler($ARGV[0], $ARGV[1]);
	
	$fh->runImport();
}

main();


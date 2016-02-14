#!/usr/bin/perl

use strict;
use warnings;

# Using a perl module from a custom directory
use FindBin;
use lib "$FindBin::RealBin/models";

use Distro;
use POSIX qw(strftime);
use File::Copy;
use Data::Dumper;

$|=1;

sub main {
	print "FileLoader\n\n";
	
	# Exit unless we have the correct number of command-line args
	my $num_args = $#ARGV + 1;
	if ($num_args != 2) {
	    print "Usage: fileloader.pl path file_mask\nExample: fileloader.pl /var/loader_files headers.tsv\n";
	    exit;
	}
	
	my $path = $ARGV[0];
	my $filename = $ARGV[1];
	 
	my $filepath = "$path/$filename";
	my $numRowsRead = 0;
	my $numRowsLoaded = 0;
	my @line;
	my $errorMsg = "=> Error: row %d was not loaded: ";
	
	open(my $fh, '<:encoding(UTF-8)', $filepath) or die "Could not open file '$filepath' $!";
 
	my $distro = new Distro();
 
	while (my $row = <$fh>) {		
	  chomp $row;
	  
	  @line = split /\t/, $row;
	  
	  # If the line is empty
	  if (! defined $line[0] && ! defined $line[1]) {
	  	printf($errorMsg . "row is empty\n", $numRowsRead);
	  	$numRowsRead++;
	  	next;
	  }
	  
	  # Jump the header
	  if ($line[0] eq "ID") {
	  	next;
	  }
	  
	  # If there's no ID
	  if($line[0] eq '') {
	  	printf($errorMsg . "ID is empty\n", $numRowsRead);
	  	$numRowsRead++;
	  	next;
	  }
	  
	  # If there's no Name
	  if($line[1] eq '') {
	  	printf($errorMsg . "Name is empty\n", $numRowsRead);
	  	$numRowsRead++;
	  	next;
	  }
	  
	  # If the date is not valid
	  if($line[2] !~ /^(((\d{4})(-)(0[13578]|10|12)(-)(0[1-9]|[12][0-9]|3[01]))|((\d{4})(-)(0[469]|1‌​1)(-)([0][1-9]|[12][0-9]|30))|((\d{4})(-)(02)(-)(0[1-9]|1[0-9]|2[0-8]))|(([02468]‌​[048]00)(-)(02)(-)(29))|(([13579][26]00)(-)(02)(-)(29))|(([0-9][0-9][0][48])(-)(0‌​2)(-)(29))|(([0-9][0-9][2468][048])(-)(02)(-)(29))|(([0-9][0-9][13579][26])(-)(02‌​)(-)(29)))$/) {
	  	print "=> Error: row $numRowsRead was loaded with today's date: Date informed is invalid\n";
	  	$line[2] = strftime "%Y-%m-%d", localtime;
	  }
	  
	  #print Dumper(@line);
	  
	  #$distro->save(@line);
	  
	  print "=> Loaded: $line[1] ($line[0])\n";
	  
	  $numRowsRead++;
	  $numRowsLoaded++;
	}
	
	#my $executedDir = "executed";
	#mkdir $path . "/$executedDir" unless -d $path . "/$executedDir";
	#move($filepath, $path . "/$executedDir/" . $filename) or die "The move operation failed: $!";
	
	if($numRowsLoaded == 0) {
		print "\nNo rows were loaded from $filename\n";
	} else {
		print "\nNumber of records imported: $numRowsLoaded\n";
	}

}

main();


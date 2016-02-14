#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::RealBin/models";

use Distro;

package FileHandler;

my $distro;
my $path;
my $fileName;
my $filePath;
my $numRowsRead = 0;
my $numRowsLoaded = 0;
my @line;

sub new {
	my $class = shift;
	my $self = {
        _path => shift,
        _fileName  => shift,
    };
    
    $path = $self->{_path};
    $fileName = $self->{_fileName};
    $filePath = "$path/$fileName";
	
	$distro = new Distro();
	
	bless $self, $class;
    return $self;
}

sub runImport {	
	readFile();
	
	if($numRowsLoaded == 0) {
		print "\nNo rows were loaded from $fileName\n";
	} else {
		print "\nNumber of records imported: $numRowsLoaded\n";
	}
	
	moveFile();
}

sub readFile {	
	open(my $fh, '<:encoding(UTF-8)', $filePath) or die "Could not open file '$filePath' $!";
	
	while (my $row = <$fh>) {
		chomp $row;
	  
		@line = split /\t/, $row;
	  
		if(!validateRow()) {
			next;
		}
		
		saveToDB();
		
		$numRowsRead++;
		$numRowsLoaded++;
	}
}

sub validateRow {
	use POSIX qw(strftime);
	
	my $errorMsg = "=> [ERROR]: row %d was not loaded: ";
	
	# If the line is empty
	if (! defined $line[0] && ! defined $line[1]) {
		printf($errorMsg . "row is empty\n", $numRowsRead);
		$numRowsRead++;
		return 0;
	}
  
	# Jump the header
	if ($line[0] eq "ID") {
		$numRowsRead++;
		return 0;
	}
  
	# If there's no ID
	if($line[0] eq '') {
		printf($errorMsg . "ID is empty\n", $numRowsRead);
		$numRowsRead++;
		return 0;
	}
  
	# If there's no Name
	if($line[1] eq '') {
		printf($errorMsg . "Name is empty\n", $numRowsRead);
		$numRowsRead++;
		return 0;
	}
  
	# If the date is not valid
	if($line[2] !~ /^(((\d{4})(-)(0[13578]|10|12)(-)(0[1-9]|[12][0-9]|3[01]))|((\d{4})(-)(0[469]|1‌​1)(-)([0][1-9]|[12][0-9]|30))|((\d{4})(-)(02)(-)(0[1-9]|1[0-9]|2[0-8]))|(([02468]‌​[048]00)(-)(02)(-)(29))|(([13579][26]00)(-)(02)(-)(29))|(([0-9][0-9][0][48])(-)(0‌​2)(-)(29))|(([0-9][0-9][2468][048])(-)(02)(-)(29))|(([0-9][0-9][13579][26])(-)(02‌​)(-)(29)))$/) {
		print "=> [ERROR]: row $numRowsRead was loaded with today's date: Date informed is invalid\n";
		$line[2] = strftime "%Y-%m-%d", localtime;
		return 1;
	} 
	
	return 1;
}

sub saveToDB {
	my $res = $distro->save(@line);
	print "=> $res: $line[1] ($line[0])\n";
}

sub moveFile {
	use File::Copy;
	
	my $executedDir = "executed";
	mkdir $path . "/$executedDir" unless -d $path . "/$executedDir";
	move($filePath, $path . "/$executedDir/" . $fileName) or die "The move operation failed: $!";
}

1;
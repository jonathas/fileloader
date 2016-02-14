#!/usr/bin/perl

use strict;
use warnings;

# Using a perl module from a custom directory
use FindBin;
use lib "$FindBin::RealBin/models";
use lib "$FindBin::RealBin/tests";

$|=1;

use Test::More tests => 2;
BEGIN {
    use_ok('EMA');
    ok(EMA->new(3));
}

use Distro;
use Data::Dumper;

my $filename = 'loader_files/distros.tsv';
my @test; 

open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";
 
 my $distro = new Distro();
 
while (my $row = <$fh>) {
  chomp $row;
  @test = split /\t/, $row;
  #print Dumper($test[0]);
  print Dumper($distro->add(@test));
  #print "$row\n";
}

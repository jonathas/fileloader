use strict;
use warnings;

# Using a perl module from a custom directory
use FindBin;
use lib "$FindBin::RealBin/tests";

$|=1;

use Test::More tests => 2;
BEGIN {
    use_ok('EMA');
    ok(EMA->new(3));
}
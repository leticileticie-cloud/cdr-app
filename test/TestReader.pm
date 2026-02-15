#!/usr/bin/env perl
package TestReader;

use strict;
use warnings;
use Test::More;
use Test::Output;

use lib 'lib';
use Reader;

sub run_readerTests {
# Test: retrieve with nonexistent type (should die)
{    
    eval { Reader::retrieve('nonexistent_type', '0'); };
    my $error = $@;
	like($error, qr/Invalid type/, 'Dies if retrieve called with nonexistent type.');
}    
}

1;
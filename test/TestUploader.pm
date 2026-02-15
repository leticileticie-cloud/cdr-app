#!/usr/bin/env perl
package TestUploader;

use strict;
use warnings;
use Test::More;

use lib 'lib';
use Uploader;

sub run_uploaderTests {
# Test: file does not exist (should die)
{
	my $error;
	eval { Uploader::upload_file('nonexistent.csv'); };
	$error = $@;
	like($error, qr/does not exist/, 'Dies if file does not exist.');
}

# Test: wrong extension (should die)
{
	open my $fh, '>', 'test.txt'; print $fh "dummy"; close $fh;
	eval { Uploader::upload_file('test.txt'); };
	my $error = $@;
	like($error, qr/Only \.csv files are allowed/, 'Dies if file has wrong extension.');
	unlink 'test.txt';
}

#TODO: Tests for db upload functionality. 
}

1;
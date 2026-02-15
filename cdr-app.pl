#!/usr/bin/env perl
use strict;
use warnings;

use lib 'lib';
use ArgParser;
use Uploader;

# Calls the option parser to check command-line arguments.
if (ArgParser::check_options()) {
    # upload option was selected
    my $upload = ArgParser::get_upload();
    if ($upload) {
        Uploader::upload_file($upload);
        print "Uploading file to database was successful.\n";
        exit(1);
    } 
}
else {
    die;
}
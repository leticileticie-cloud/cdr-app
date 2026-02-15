#!/usr/bin/env perl
use strict;
use warnings;

use lib 'lib';
use ArgParser;
use Uploader;
use Reader;

# Calls the option parser to check command-line arguments.
if (ArgParser::check_options()) {
    # upload option was selected
    my $upload = ArgParser::get_upload();
    if ($upload) {
        Uploader::upload_file($upload);
        print "Uploading file to database was successful.\n";
        exit(1);
    } 

    # retrieve option was selected with one positional argument needed
    my $type = ArgParser::get_retrieve();
    my $value = ArgParser::get_firstPositional();
    if ($type && $value) {
        my $optional = ArgParser::get_optPositional();
        Reader::retrieve($type, $value, $optional); 
        exit(1);
    }
}
else {
    die;
}
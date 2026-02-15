#!/usr/bin/env perl
use strict;
use warnings;

use lib 'lib';
use ArgParser;

if (ArgParser::check_options()) {
    print "Options were successfully parsed\n";
}
else {
    die;
}
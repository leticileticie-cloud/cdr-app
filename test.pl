#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use lib 'test';
use TestArgParser;
use TestUploader;

TestArgParser::run_argParserTests();
TestUploader::run_uploaderTests();

done_testing();
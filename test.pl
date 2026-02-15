#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use lib 'test';
use TestArgParser;
use TestUploader;
use TestReader;
use TestDatabase;

TestArgParser::run_argParserTests();
TestUploader::run_uploaderTests();
TestReader::run_readerTests();
TestDatabase::run_databaseTests();

done_testing();
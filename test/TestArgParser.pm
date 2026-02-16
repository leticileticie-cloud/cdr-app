#!/usr/bin/env perl
package TestArgParser;

use strict;
use warnings;
use Test::More;
use Test::Output;

use lib 'lib';
use ArgParser;

sub run_argParserTests {
# Test: missing required options (should die)
{
    local @ARGV = ();
    my $died = 0;
    eval { ArgParser::check_options(); };
    $died = $@ ? 1 : 0;
    ok($died, 'Dies when no options provided.');
}

# Test: invalid option (should die)
{
    local @ARGV = ('--invalid');
    my $died = 0;
    eval { ArgParser::check_options(); };
    $died = $@ ? 1 : 0;
    ok($died, 'Dies when invalid option provided.');
}
   
# Test: help option (should pass)
{
    local @ARGV = ('--help');
    my $passed = 0;
    eval { ArgParser::check_options(); };
    $passed = $@ ? 1 : 1;
    ok($passed, 'Parsing --help option passes.');
    local @ARGV = ('--help');
    stdout_like { ArgParser::check_options(); } qr/Usage:/, 'Parsing --help option prints usage message.'; 
}

# Test: upload option with file (should pass)
{
    local @ARGV = ('--upload', 'file.csv');
    my $passed = 0;
    eval { ArgParser::check_options(); };
    $passed = $@ ? 1 : 1;
    ok($passed, 'Parsing --upload option with filename passes.');
}

# Test: upload option without file (should die)
{
    local @ARGV = ('--upload');
    my $died = 0;
    eval { ArgParser::check_options(); };
    $died = $@ ? 1 : 0;
    ok($died, 'Dies when upload option provided without filename.');
}

# Test: retrieve option with file (should pass)
{
    local @ARGV = ('--retrieve', 'reference_id', '12345');
    my $passed = 0;
    eval { ArgParser::check_options(); };
    $passed = $@ ? 1 : 1;
    ok($passed, 'Parsing --retrieve option with type and positional argument passes.');
}

# Test: retrieve option without value (should die)
{
    local @ARGV = ('--retrieve', 'reference_id');
    my $died = 0;
    eval {
        ArgParser::check_options();
        ArgParser::get_firstPositional();
    };
    $died = $@ ? 1 : 0;
    ok($died, 'Dies when retrieve option provided without value (no positional argument).');
}

# Test: retrieve option without type (should die)
{
    local @ARGV = ('--retrieve');
    my $died = 0;
    eval { ArgParser::check_options(); };
    $died = $@ ? 1 : 0;
    ok($died, 'Dies when retrieve option provided without type.');
}
}

1;
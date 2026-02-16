#!/usr/bin/env perl
package ArgParser;

use strict;
use warnings;

use Getopt::Long;

my $upload = '';
my $retrieve = '';

# Prints usage message if script is given none or invalid options or if --help is called.
sub usage {
    print << "USAGE";
    Usage: $0 [options] [--] [positional args...]

    Options:
    -h, --help              Show this help and exit.
    -u, --upload FILE       Upload .csv file from given path.
    -r, --retrieve TYPE     Retrieve entries of given type (reference_id, caller_id).
                            Requires one positional argument for value.
                            For caller_id requires at least one more positional argument for date 
                            or date range.

    Any remaining arguments after options are treated as positional arguments.
USAGE
}

# Parses command-line options and stores them.
sub check_options {
    my $help = 0;

    GetOptions(
        'help|h'            => \$help,
        'upload|u=s'        => \$upload,
        'retrieve|r=s'      => \$retrieve,
    ) or die(usage());
    usage() if $help;
    usage() and die unless $help || $upload || $retrieve;

    return 1;
}

sub get_upload {
    return $upload;
}

sub get_retrieve {
    return $retrieve;
}

sub get_firstPositional {
    my $value = $ARGV[0];
    if (!$value) {
        die "Positional arguments are needed for selected option.\n";
    }

    return $value;
}

sub get_optPositional {
    if(scalar @ARGV < 2) {
        return [];
    }
    else {
        my $ref = [@ARGV[1..$#ARGV]];
        return $ref;
    }
}

1;
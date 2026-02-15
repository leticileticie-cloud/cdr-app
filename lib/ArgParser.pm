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
    -r, --retrieve TYPE     Retrieve entries of given type (reference_id).

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
        die "One positional argument is needed for selected option.\n";
    }

    return $value;
}

1;
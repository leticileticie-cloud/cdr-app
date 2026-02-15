#!/usr/bin/env perl
package ArgParser;

use strict;
use warnings;

use Getopt::Long;

my $upload = '';

# Prints usage message if script is given none or invalid options or if --help is called.
sub usage {
    print << "USAGE";
    Usage: $0 [options] [--] [positional args...]

    Options:
    -h, --help              Show this help and exit.
    -u, --upload FILE       Upload .csv file from given path.

    Any remaining arguments after options are treated as positional arguments.
USAGE
}

# Parses command-line options and stores them.
sub check_options {
    my $help = 0;

    GetOptions(
        'help|h'            => \$help,
        'upload|u=s'        => \$upload,
    ) or die(usage());
    usage() if $help;
    usage() and die unless $help || $upload;

    return 1;
}

1;
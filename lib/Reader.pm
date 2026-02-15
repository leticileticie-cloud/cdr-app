#!/usr/bin/env perl
package Reader;

use strict;
use warnings;

use Database;

my @types = qw/reference_id caller_id/;

# Retrieves and prints entries from data.json matching the given type and value.
sub retrieve {
    my ($type, $value, $optional) = @_;
    my $correct = 0;
    foreach my $t (@types) {
        if ($type eq $t) {
            $correct = 1;
        }
    }
    if (!$correct) {
        die "Invalid type '$type' for retrieval. Valid types are: " . join(', ', @types) . "\n";
    }

    my ($start_date, $end_date) = ('', '');
    if ($type eq 'caller_id') {
        if (scalar(@$optional) >= 1) {
            $start_date = $optional->[0];
            $end_date = $start_date; # default to start_date if end_date is not provided
            if (exists $optional->[1]) {
                $end_date = $optional->[1];
            }
            #TODO: Check date format and whether start_date <= end_date.
        }
        else {
            die "No date given for $type retrieval.\n"; 
            #TODO: Possibly default to today's date.
        }
    }
    
    my $dbh = Database::connectDB_or_die();
    if ($type eq 'reference_id') {
        my $sql = Database::prepare_query($dbh, "SELECT * FROM cdr WHERE $type = ?");
        Database::print_results($sql, $value);
    }
    else {
        my $sql = Database::prepare_query($dbh, "SELECT * FROM cdr WHERE caller_id = ? AND date >= ? AND date <= ?");
        Database::print_results($sql, $value, $start_date, $end_date);
    }
    Database::disconnectDB($dbh);
}
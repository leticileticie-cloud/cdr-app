#!/usr/bin/env perl
package Reader;

use strict;
use warnings;

use Database;

my @types = qw/reference_id/;

# Retrieves and prints entries from data.json matching the given type and value.
sub retrieve {
    my ($type, $value) = @_;
    my $correct = 0;
    foreach my $t (@types) {
        if ($type eq $t) {
            $correct = 1;
        }
    }
    if (!$correct) {
        die "Invalid type '$type' for retrieval. Valid types are: " . join(', ', @types) . "\n";
    }
    
    my $dbh = Database::connectDB_or_die();
    my $sql = Database::prepare_query($dbh, "SELECT * FROM cdr WHERE $type = ?");
    Database::print_results($sql, $value);
    Database::disconnectDB($dbh);
}
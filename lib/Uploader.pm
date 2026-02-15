#!/usr/bin/env perl
package Uploader;

use strict;
use warnings;
use File::Basename;

use Database;

sub upload_file {
    my ($file) = @_;
    if (!-e $file) {
        die "File to be uploaded '$file' does not exist.\n";
    }
    my $extension = (fileparse($file, qr/\.[^.]*/))[2];
    if ($extension ne '.csv') {
        die "Only .csv files are allowed for upload.\n";
    }

    open my $input_fh, '<', $file or die "Could not open '$file': $!";
    my $dbh = Database::connectDB_or_create();
    my $sql = Database::prepare_query($dbh, "INSERT INTO cdr (caller_id, callee_id, date, end_time, duration, cost, reference_id, currency, call_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
   
    my @parts;
    while (my $line = <$input_fh>) {
        chomp $line;
        @parts = split ',', $line;
        #TODO: validate line format and values before executing statement
        Database::fill_table($sql, @parts);                
    }  
    Database::disconnectDB($dbh);
    close $input_fh;
}

1;

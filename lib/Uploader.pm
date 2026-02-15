#!/usr/bin/env perl
package Uploader;

use strict;
use warnings;
use File::Basename;use DBI;

my $dbfile = "cdr.db";

sub connect_db {
    if (!-e $dbfile) {
        my $sql = <<'SCHEMA';
CREATE TABLE cdr (
   reference_id VARCHAR(100) PRIMARY KEY,
   caller_id VARCHAR(100),
   callee_id VARCHAR(100),
   date DATE,
   end_time TIME,
   duration INTEGER,
   cost REAL,
   currency VARCHAR(10),
   call_type VARCHAR(50)
);
SCHEMA

        my $dbh = DBI->connect ("dbi:SQLite:$dbfile");
        die "connect failed: $DBI::errstr" if ! $dbh;
        $dbh->do($sql) or die "Could not create table: $DBI::errstr";

        return $dbh
    }
    else {
        my $dbh = DBI->connect ("dbi:SQLite:$dbfile");
        die "connect failed: $DBI::errstr" if ! $dbh;

        return $dbh
    }
}

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
    my $dbh = connect_db();
    my $sql = $dbh->prepare("INSERT INTO cdr (caller_id, callee_id, date, end_time, duration, cost, reference_id, currency, call_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

    my @parts;
    while (my $line = <$input_fh>) {
        chomp $line;
        @parts = split ',', $line;
        #TODO: validate line format and values before executing statement
                    
        $sql->execute(@parts) or die "Could not execute statement: $DBI::errstr";      
    }  
    close $input_fh;
}

1;

#!/usr/bin/env perl
package Database;

use strict;
use warnings;
use DBI;

my $dbfile = "cdr.db";

sub connectDB_or_create {
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

sub connectDB_or_die {
    if (!-e $dbfile) {
        die "Database file '$dbfile' does not exist. Please upload a .csv file to create the database.\n";
    }
    my $dbh = DBI->connect ("dbi:SQLite:$dbfile");
    die "connect failed: $DBI::errstr" if ! $dbh;

    return $dbh
}

sub disconnectDB {
    my ($dbh) = @_;
    $dbh->disconnect();
}

sub prepare_query {
    my ($dbh, $sql) = @_;
    my $sth = $dbh->prepare($sql);
    die "Failed to prepare query: $DBI::errstr" if ! $sth;
   
    return $sth;
}

sub fill_table {
    my ($sth, @params) = @_;
    $sth->execute(@params) or die "Failed to execute query: $DBI::errstr";
}

sub print_results {
    my ($sth, @params) = @_;
    $sth->execute(@params) or die "Failed to execute query: $DBI::errstr";
    my @result;
    while (my $row = $sth->fetchrow_arrayref()) {
        push @result, [@$row];
    }
    if (!@result) {
        print "No match found.\n";
        exit(1);
    }
    foreach my $row (@result) {
        print join(", ", @$row) . "\n";
        #TODO: format output more nicely
    }
}
ABOUT:
This script is developed using Strawberry Perl. It's meant to load CDR data from given .csv file and to execute some search and aggregate queries over them. Given data are loaded to SQL local database created with DBI module. 
The use of SQL database is chosen for many reasons. It's using much less storage space than the original files. Using constraints of a database table offers easy validation of given data. For example the same .csv file can't be loaded twice, because it isn't allowed to store more than one entry with the same primary key (CDR reference is used). Also the use of SQL itself offers widely known approach how to filter large amount of data.
Unit tests are implemented with the use of Test::More and Test::Output modules which are widely used by Perl community.

USAGE:
This software operates as a simple script executable from command line. It's expecting one-time input using arguments as follows:

    Options:
    -h, --help              Show this help and exit.
    -u, --upload FILE       Upload .csv file from given path.
    -r, --retrieve TYPE     Retrieve entries of given type (reference_id, caller_id).
                            Requires one positional argument for value.
                            For caller_id requires at least one more positional argument for date 
                            or date range.
    Any remaining arguments after options are treated as positional arguments. 

Examples of running the script:
    perl cdr-app.pl -u 'path-to-csv-file'
    perl cdr-app.pl -r reference_id 'value_of_reference_id'
    perl cdr-app.pl -r caller_id 'value_of_caller_id' 'start_date'  
    perl cdr-app.pl -r caller_id 'value_of_caller_id' 'start_date' 'end_date' 

Script launching a test suite is also provided. It's executed like this:
    perl test.pl

ASSUMPTIONS:
The script isn't tested with a real large .csv file. However online sources claim that simple iteration over the file shouldn't use up the memory.  

IMPROVEMENT:
There is a lot of stuff to improve:
    Considering above assumption, using Text::CSV_XS module. 
    Merging columns date and end_time into one column time_stamp. 
    Storing values of call_type as DOMESTIC or INTERNATIONAL to avoid confusion of numerical values.
    Finish SQL queries logic in Reader.pm to satisfy all requirements. Create a subroutine to produce these queries.
    Thorough unit test suite.
    Use OOP approach (implementing constructors).
use strict;
use warnings;

use Getopt::Long;

my ($f_json_in, $name_out, $help);

GetOptions(
    'a|json_in=s'       => \$f_json_in,
    'o|output_prefix=s'  => \$name_out,
    'h|help'             => \$help,
);

( ($f_json_in && $name_out) && !$help) || die <<USAGE;

Usage: $0
    -a|json file
    -o|prefix for output files
    -h|this help message 

USAGE

# Files
my $f_out = $name_out . '_parsed.json';

open(my $h_out, '>>', $f_out);

## Parse json file
open(my $h_in, '<', $f_json_in);
my ($line, $old_line) = ('','');

while(<$h_in>){
    chomp;
    $line = $_;    

    if($line =~ /^data/ ){

        $line =~ s/^.*$/\[/;
        print $h_out "$line\n";

    }elsif($line =~ /^\{'docume/){ # comment line, drop it

    }elsif ($line =~ /^\{/){ # Parse to valid json

        unless ($old_line eq ""){ print $h_out "$old_line,\n"}

        # key pars have to be double quoted in json, they are single quoted in the original files
        # take into account that there could be single quoted inside the values (doubled quoted)

        $line =~ s/'([^"]+?)':/"$1":/g;
        $line =~ s/: None/: "None"/g; # Some None values are double quoted, some are not
        $line =~ s/\a//g; # There is a bell character ^G in one of the lines

        #print $h_out "$line\n";

        $line =~ s/,$//; # remove trailing comma, the comma in the last line is not allowed
        $old_line = $line;

    }else{}
}
# Print last line
print $h_out "$old_line\n]\n";

close $h_in;
close $h_out;

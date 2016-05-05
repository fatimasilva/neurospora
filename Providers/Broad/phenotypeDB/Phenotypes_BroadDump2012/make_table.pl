#!/usr/bin/perl -w
use strict;
use warnings;
use Text::CSV;
 my $csv = Text::CSV->new();
my $dir = shift || ".";
opendir(DIR,$dir) || die $!;
my %table;
my %phenos;
for my $pheno ( readdir(DIR) ) {
    next if $pheno =~ /^\./ || ! -d "$dir/$pheno";
    my $name = $pheno;

    opendir(PHENOS,"$dir/$pheno") ||die $!;
    for my $file ( readdir(PHENOS) ) {
	my $filename = $file;
	if( $file =~ s/\.csv$//) {
	    $file =~ s/\s+/_/g;
	    $phenos{$name} = $file;
	    
	    open(my $fh => "$dir/$pheno/$filename" ) || die "$filename: $!";
	    my $watch_col;
	    my $header = $csv->getline($fh);		
	    my $i =0;
	    my %header = map {$_ => $i++ } @$header;	
	    
	    if( ! $header{'Locus'} ) {
		warn "no Locus column for file $pheno/$filename\n";
		warn("header was @$header\n");
		next;
	    }
	    while(my $row = $csv->getline($fh)) {
		my $gene = $row->[ $header{'Locus'} ];
		$table{$gene}->{$pheno}->{$file}++;	    	
	    }
	}
    }
    
}

my @phenos = sort keys %phenos;
$csv->print(\*STDOUT,['GENE',@phenos]);
print "\n";
for my $gene ( sort keys %table ) {
    $csv->print(\*STDOUT,[$gene, map 
			  { exists $table{$gene}->{$_} ? 
				join(",",keys %{$table{$gene}->{$_}})
				: 'NA' } @phenos]);
    print "\n";
}

This is basically dumps of data I got from Broad, I think there were problems, a better spreadsheet has been collected by the Borkovich lab (UCR).

Images are not stored in this git repository, they are available [here](http://fungalgenomes.org/public/neurospora/data/phenotype/all_images/)

Files:

* *missing_images_list.txt*: images referenced in the phenotype annotation files but missing from the Broad dump.

* *phenoImages_2012_08_15.tsv.gz*: tab file wiht phenotype annotations (controlled curation based annotations). Dumped from the Broad SQL database.

* *phenoImages_with_locus.csv.gz*: tab file with growth rate annotations. Dumped from the Broad SQL database.

* *images/simple_grid_view/*: structure of web pages at [Fungal Genomes](http://fungalgenomes.org) that provides the available [images indexed by gene ID]((http://fungalgenomes.org/public/neurospora/data/phenotype/).

* *Phenotypes_BroadDump2012*: similar information than in *phenoImages_2012_08_15.tsv.gz* but organized by phenotype. Also a summary of phenotypes by gene ID.

* *tidy/broad_nc_phenotypes_growth_rates.tsv*: growth rates extracted from *phenoImages_with_locus.csv.gz*, with some cleanning of the 'conditions' column ('pi.title' in the original file). See [scriptname](scripts/) for details on how this file was generated.


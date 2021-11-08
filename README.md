# 2021-11-15

# Classification of the MATE gene family in plants

# Background
Multidrug and toxic compound extrusion (MATE) proteins form one of the major multidrug transporter families that mediate multiple functions in plants through the efflux of diverse substrates including organic molecules, specialized metabolites, hormones and xenobiotics. They are ubiquitous in all three domains of life and represent a multigene family in plants with a tremendous copy number and functional novelties.

# Research probelm
MATE gene family has been studied well in various plant species and classified into several groups and/or subgroups based on the phylogenetic topology. Notably, all the published MATE gene family studies examined only a limited number (i.e. <5) of plant species and named the phylogenetic clades on their own. **Since a large-scale phylogenomic study has never been conducted as well as a systematic classification has never been proposed, clear contradiction occurs on the naming of groups/ subgroups among the published genome-wide studies of plant MATEs (_see Table 1_).**

# Resolvement
To resolve the problem, a kingdom-wide analysis of the MATE gene family and synteny network analyses were performed using 74 species of different plant orders. A total of 4210 MATEs were identified through hmm profile-based search that were classified systematically into 14 subgroups using USERACH, blast+ and synteny network tools. **Classification was performed in four subsequent steps,** in which MATEs sharing ≥60% protein sequence identity (PSI) with ≤1E-05 threshold at different sequence lengths (either at the full-length, ≥60% of its length, or ≥150 amino acids of it) or retaining in the conserved genomic blocks were assigned into the same subgroup. In this way, subgroup was assigned for 95.8% of MATEs identified and the synteny network clustering analysis substantiated it. Subgroups were clustered under four major phylogenetic groups and named according to their clockwise appearance within each group. **To view the distribution of MATE subgroups across the plant kingdom,** see _MATEsDistributionInPlants.pdf_. **To view the comprehensive phylogeny of MATE gene family in plants,** see _PlantMATEsPhylogeny.svg_. **To view the synteny networks in Cytoscape,** use _PlantMATEsSyntenyNetwork.cys_.

# Classification of plant MATEs via blastp search using RefPlantMATEs dataset
To assist the classification of MATE gene family in other plant species (i.e. the species not covered in our study), a reference sequence dataset (termed as RefPlantMATEs) was prepared with 3444 MATEs of diverse plant species. Members in the dataset were comprised of 1–2 MATE domains, and their protein and domain lengths were ranged between 351–650 and 79–342 amino acids, respectively. Fasta header of the RefPlantMATEs dataset included five attributes (gene id, species, subgroup, classified criteria and protein length) separated by pipe (|). A bioinformatic pipeline (i.e. PlantMATEsClassification.sh) was then established using simple shell commands to automate the classification. The pipeline was validated with the classification of MATE gene family in wheat (i.e. TaMATEs) as test file in UBUNTU 18.04.

# Dependencies
Three tools are necessiated to perform the automatic classification of MATEs in other plant species. **Seqkit**: To install it, see https://bioinf.shenwei.me/seqkit/download/ or https://anaconda.org/bioconda/seqkit. **Blast+**: To install it, see https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download or https://anaconda.org/bioconda/blast. **Datamash**: To install it, see https://www.gnu.org/software/datamash/download/ or https://anaconda.org/bioconda/datamash.

# Usage
0. Download the repostiry. Go to the green background panel **Code --> Download ZIP**. The repository will download as PlantMATEsClassification-main.zip. Browse to the downloaded directory and unzip it.

1. Create a new directory (lets name it as XYZ).

2. Copy **TaMATEs.fa**, **RefPlantMATEs.fa**, and **PlantMATEsClassification.sh** files from the PlantMATEsClassification-main directory into the newly created XYZ directory.

3. Open terminal and navigate to the XYZ directory (alternatively you can browse into XYZ and open the terminal there). Once you navigate to the XYZ directory in the terminal, run **chmod +x PlantMATEsClassification.sh** to make the script file as executable (alternatively browse into XYZ --> right click on PlantMATEsClassification.sh --> Properties --> Permissions and tick the Execute: option).

4. Depending on the seqkit, blast+ and datamash environment, run the script file using the command **./PlantMATEsClassification.sh** in the terminal. You will get the results within 7 seconds using 10 threads. **Once you get results sucessfully, go to step 5.** Otherwise, make sure whether you run the script in the correct environment, whether the tools are installed successfully and/or whether you properly exported the tool's path to ~/.bashrc.

5. Now, you are ready to classify the MATEs of your target plant species. **If you already have query sequences in a file, go to step 6.** Query sequences (i.e. the MATE-domain (PF01554) containing proteins of your target species) can be obtained by hmmsearch with hmmer3 tool against your target proteome or by using the keyword PF01554 from any public databases (e.g. https://phytozome-next.jgi.doe.gov/). I prefer the hmmsearch method (because, here, we can limit the occurences of non-MATE sequences using gathering threshold (--cut_ga) option) over the public database search (which always includes many non-MATE sequences). To install hmmer3 see http://hmmer.org/documentation.html.

6. Copy your query sequence file into XYZ. Make sure that the fasta header of your query sequences contain only the gene_identifier and no other attributes (for example, see TaMATEs.fa).

7. Check line 26 in the PlantMATEsClassification.sh file and input the name of your query_ProteinSequence_file. Followed by, call the script using the command **./PlantMATEsClassification.sh** in the terminal as described in step 4. You will get the results within few seconds based on your query size.

**For more details, go through the pipeline which includes detailed comments for each and every step.**

# Limitations
The piepline is suitable to classify the MATEs of angiosperms. Classification of MATEs from primitive organisms (e.g. algae) is highly unlikely.
And, I have no idea whether the RefPlantMATEs dataset is usable to classify MATEs from gymnosperms.

#❗️for any queries reach me at: pselva7@gmail.com

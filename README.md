# 2021-11-09

# Classification of the MatE-domain (PF01554) containing proteins in plants

# Background
Multidrug and toxic compound extrusion (MATE) proteins form one of the major multidrug transporter families that mediate multiple functions in plants through the efflux of diverse substrates including organic molecules, specialized metabolites, hormones and xenobiotics. They are ubiquitous in all three domains of life and represent a multigene family in plants with a tremendous copy number and functional novelties.

# Probelm
MATE gene family has been studied well in various plant species and classified into several groups and/or subgroups based on the phylogenetic topology. Notably, all the published MATE gene family studies examined only a limited number (i.e. <5) of plant species and named the phylogenetic clades on their own. **Since a large-scale phylogenomic study has never been conducted as well as a systematic classification has never been proposed, clear contradiction occurs on the naming of groups/ subgroups among the published genome-wide studies of plant MATEs** (see _Table 1_).

**Table 1 |** Discrepancy in the classification of plant MATE gene family (_CGS* denotes clade, class, group and/ or subfamily_)
|     Plant species           |     CGS*          |     Subgroup                                                                                    |     References             |
|-----------------------------|-------------------|-------------------------------------------------------------------------------------------------|----------------------------|
|     Arabidopsis thaliana    |     I – IV        |     /                                                                                           |     Wang et al., 2016      |
|     Arabidopsis thaliana    |     I – V         |     /                                                                                           |     Santos et al., 2017    |
|     Brassica rapa           |     1 – 4         |     /                                                                                           |     Qiao et al., 2020      |
|     Brassica juncea         |     1 – 4         |     /                                                                                           |     Qiao et al., 2020      |
|     Brassica napus          |     1 – 4         |     /                                                                                           |     Qiao et al., 2020      |
|     Brassica nigra          |     1 – 4         |     /                                                                                           |     Qiao et al., 2020      |
|     Brassica oleracea       |     1 – 4         |     /                                                                                           |     Qiao et al., 2020      |
|     Capsicum annuum         |     I – V         |     /                                                                                           |     Chen et al., 2020      |
|     Cicer arietinum         |     G1 – G4       |     /                                                                                           |     Zhang et al., 2020     |
|     Citrus sinensis         |     I – V         |     /                                                                                           |     Juliao et al., 2020    |
|     Glycine max             |     C1 – C4       |     C1-1, C1-2, C1-3, C2-1, C2-2, C3-1, C3-2, C4-1, C4-2,   C4-3                                |     Liu et al., 2016       |
|     Gossypium arboreum      |     MI – MIII     |     /                                                                                           |     Lu et al., 2018        |
|     Gossypium hirsutum      |     C1 – C4       |     C1-1, C1-2, C1-3, C1-4, C1-5, C2, C3, C4                                                    |     Xu et al., 2018        |
|     Gossypium raimondii     |     MI – MIII     |     /                                                                                           |     Lu et al., 2018        |
|     Linum usitassimum       |     I – IV        |     /                                                                                           |     Ali et al., 2021       |
|     Malus × domestica       |     I – VI        |     /                                                                                           |     Zhang et al., 2021     |
|     Medicago sativa         |     C I – C IV    |     C I-1, C I-2, C I-3, C II-1, C II-2, C III-1, C III-2, C   III-3, C IV-1, C IV-2, C IV-3    |     Min et al., 2019       |
|     Medicago truncatula     |     I – IV        |     /                                                                                           |     Wang et al., 2017      |
|     Nicotiana tabacum       |     I – IV        |     Ia, Ib, Ic, Id, Ie, IIa, IIb, IIc, III, IVa, IVb                                            |     Gani et al., 2021      |
|     Oryza sativa            |     1 – 4         |     /                                                                                           |     Du et al., 2021        |
|     Oryza sativa            |     C1–C4         |     C1-1, C1-2, C2, C3-1, C3-2, C4-1, C4-2, C4-3, C4-4                                          |     Huang et al., 2019     |
|     Oryza sativa            |     I – IV        |     /                                                                                           |     Wang et al., 2016      |
|     Populus trichocarpa     |     I – III       |     Ia, Ib, IIa, IIb, IIc, IIIa, IIIb, IIIc                                                     |     Li et al., 2017        |
|     Solanum lycopersicum    |     I – V         |     /                                                                                           |     Santos et al., 2017    |
|     Solanum tuberosum       |     I – V         |     /                                                                                           |     Huang et al., 2021     |
|     Solanum tuberosum       |     I – VI        |     /                                                                                           |     Li et al., 2019        |
|     Solanum tuberosum       |     I – V         |     /                                                                                           |     Chen et al., 2020      |
|     Vaccinium corymbosum    |     I – V         |     /                                                                                           |     Chen et al., 2015      |
|     Zea mays                |     I – VII       |     /                                                                                           |     Zhu et al., 2016       |

# Resolvement
To resolve the problem, a kingdom-wide analysis of the MATE gene family and synteny network analyses were performed using 74 species of different plant orders. A total of 4210 MATEs were identified through hmm profile-based search that were classified systematically into 14 subgroups using USERACH, blast+ and synteny network tools. **Classification was performed in four subsequent steps** (**_see PlantMATEsClassificationOverview.pdf_**), in which MATEs sharing ≥60% protein sequence identity (PSI) with ≤1E-05 threshold at different sequence lengths (either at the full-length, ≥60% of its length, or ≥150 amino acids of it) or retaining in the conserved genomic blocks were assigned into the same subgroup. In this way, subgroup was assigned for 95.8% of MATEs identified and the synteny network clustering analysis substantiated it. Subgroups were clustered under four major phylogenetic groups and named according to their clockwise appearance within each group. **To view the distribution of MATE subgroups across the plant kingdom,** see _MATEsDistributionInPlants.pdf_. **To view the comprehensive phylogeny of MATE gene family in plants,** see _PlantMATEsPhylogeny.svg_. **To view the synteny network of MATE gene family in plants,** open _PlantMATEsSyntenyNetwork.cys in Cytoscape_.  

**Established PlantMATEsPhylogeny:**
![This is an image](/PlantMATEsPhylogeny.svg)

# Classification of plant MATEs via blastp search using RefPlantMATEs dataset
To assist the classification of MATE gene family in other plant species (i.e. the species not covered in our study), a reference sequence dataset (termed as RefPlantMATEs) was prepared with 3444 MATEs of diverse plant species. Members in the dataset were comprised of 1–2 MATE domains, and their protein and domain lengths were ranged between 351–650 and 79–342 amino acids, respectively. Fasta header of the RefPlantMATEs dataset included five attributes (gene id, species, subgroup, classified criteria and protein length) separated by pipe (|). A bioinformatic pipeline (i.e. PlantMATEsClassification.sh) was then established using simple shell commands to automate the classification. The pipeline was validated with the classification of MATE gene family in wheat (i.e. TaMATEs).

# Dependencies
Three tools are necessiated to perform the automatic classification of MATEs in other plant species. **Seqkit**: To install it, see https://bioinf.shenwei.me/seqkit/download/ or https://anaconda.org/bioconda/seqkit. **Blast+**: To install it, see https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download or https://anaconda.org/bioconda/blast. **Datamash**: To install it, see https://www.gnu.org/software/datamash/download/ or https://anaconda.org/bioconda/datamash.

# Usage
**0.** Download the repostiry. To downolad it, go to the green background panel **Code --> Download ZIP**. The repository will download as PlantMATEsClassification-main.zip. Browse to the downloaded directory and unzip it.

**1.** Create a new directory (lets name it as XYZ).

**2.** Copy **TaMATEs.fa**, **RefPlantMATEs.fa**, **PlantMATEsClassification.sh**, **TaMATEsClassificationLogOriginal** and **TaMATEsClassificationSummaryOriginal** files from the PlantMATEsClassification-main directory into the newly created XYZ directory.

**3.** Open terminal and navigate to the XYZ directory (alternatively you can browse into XYZ and open the terminal there). Once you navigate to the XYZ directory in the terminal, run **```chmod +x PlantMATEsClassification.sh```** to make the script file as executable (alternatively browse into XYZ --> right click on PlantMATEsClassification.sh --> Properties --> Permissions and tick the Execute: option).

**4.** Depending on the seqkit, blast+ and datamash environment, run the script file using the command **```./PlantMATEsClassification.sh```** in the terminal. You will get the results within 7 seconds using 10 threads. Compare the output files TaMATEsClassificationLog and TaMATEsClassificationSummary with TaMATEsClassificationLogOriginal and TaMATEsClassificationSummaryOriginal, respectively, using the commands:

   **```diff -qs <(tail -n +2 TaMATEsClassificationLogOriginal) <(tail -n +2 TaMATEsClassificationLog)```**
   
   **```diff -qs TaMATEsClassificationSummaryOriginal TaMATEsClassificationSummary```**

   If the outputs show **"_Files ... and ... are identical_", go to step 5.** Otherwise, make sure whether you run the script in the correct environment, whether the tools are installed successfully and/or whether you properly exported the tool's path to ~/.bashrc.

**5.** Now, you are ready to classify the MATEs of your target plant species. **If you already have query protein sequences in a file, go to step 6.** Query sequences (i.e. the MATE-domain (PF01554) containing proteins of your target species) can be obtained by hmmsearch with hmmer3 tool against your target proteome or by using the keyword PF01554 from any public databases (e.g. https://phytozome-next.jgi.doe.gov/). I prefer the hmmsearch method (because, here, we can limit the occurences of non-MATE sequences using gathering threshold (--cut_ga) option) over the public database search (which always includes many non-MATE sequences).  
**To install hmmer3**, see http://hmmer.org/documentation.html.  
**To download MatE (PF01554) domain**, go to http://pfam.xfam.org/family/mate#tabview=tab6.  
**To retrieve MatE domain containing proteins** from the target proteome with gathering threshold option, use the following commands:
   ```
       hmmsearch --cut_ga --tblout QuerySpecies.table -o QuerySpecies.out --noali MatE.hmm QuerySpeciesProteomeFile
       grep -v "#" QuerySpecies.table > QuerySpecies.table1
       awk -F " " '{print $1}' QuerySpecies.table1 | sort -u > QuerySpeciesGeneIDs
       seqtk subseq QuerySpeciesProteomeFilea QuerySpeciesGeneIDs > QuerySpeciesMATEs.fa
   ```
   
**6.** Copy your query protein sequence file into XYZ. Make sure that the fasta header of your query protein sequences contain only the gene_identifier and no other attributes (for example, see TaMATEs.fa).

**7.** Check line 26 in the PlantMATEsClassification.sh file and input the name of your query_ProteinSequence_file. Followed by, call the script using the command **```./PlantMATEsClassification.sh```** in the terminal as described in step 4. You will get the results within few seconds based on your query size.

**For more details, go through the pipeline which includes detailed comments for each and every step.**

# Limitations
The piepline is suitable to classify the MATEs of angiosperms. Classification of MATEs from primitive organisms (e.g. algae) is highly unlikely.
And, I have no idea whether the RefPlantMATEs dataset is usable to classify MATEs from gymnosperms. It is because, no gymnosperm species was analzyed in our study.

**#❗️for any queries reach me at:** pselva7@gmail.com

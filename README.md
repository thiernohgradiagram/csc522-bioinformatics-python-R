# csc522-bioinformatics-python-R
I am building a bioinformatics pipeline with python, R and snakemake

* snakemake best practice > https://snakemake.readthedocs.io/en/stable/snakefiles/best_practices.html
* uri vpn                 > https://its.uri.edu/itsec/vpn-enrollment/
* snakemake-tutorial      > https://snakemake.readthedocs.io/en/stable/tutorial/basics.html                  

## Installation && setup 
    Install a conda-based python3 distribution.
    The recommended conda-based python 3 distribution is Mambaforge, which comes with the required commands for python, and the required commands for the conda, mamba package managers.
    It is recommended to always use the mamba package manager instead of conda.

    Installing Mambaforge on linux
    Mambaforge will now be installed into this location: /home/thiernoh_gradiagram_uri_edu/mambaforge
    curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -o Mambaforge-Linux-x86_64.sh
    bash Mambaforge-Linux-x86_64.sh

    Installing Mambaforge on MacOS x86_64 architecture
    Mambaforge will now be installed into this location: /home/thiernoh_gradiagram_uri_edu/mambaforge
    curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-x86_64.sh -o Mambaforge-MacOSX-x86_64.sh
    bash Mambaforge-MacOSX-x86_64.sh

    Installing Mambaforge on MacOS ARM/M1 architecture
    Mambaforge will now be installed into this location: /home/thiernoh_gradiagram_uri_edu/mambaforge
    curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-arm64.sh -o Mambaforge-MacOSX-arm64.sh
    bash Mambaforge-MacOSX-arm64.sh

    Do you wish the installer to prepend the install location to PATH ...? [yes|no] 

    Do you wish to update your shell profile to automatically initialize conda?
    This will activate conda on startup and change the command prompt when activated.
    If you'd prefer that conda's base environment not be activated on startup,
    run the following command when conda is activated: conda config --set auto_activate_base false

    Clone the repo and Navigate to the project  
    cd /work/pi_bps542_uri_edu/Projects/snakemake-tutorial

    Download some example data on which the workflow shall be executed
    curl -L https://api.github.com/repos/snakemake/snakemake-tutorial-data/tarball -o snakemake-tutorial-data.tar.gz

    Extract the data > this will create a folder data and a file environment.yaml in the working directory.
    tar --wildcards -xf snakemake-tutorial-data.tar.gz --strip 1 "*/data" "*/environment.yaml" (LINUX)
    tar -xf snakemake-tutorial-data.tar.gz --strip 1 "*/data" "*/environment.yaml" (MAC)

    

    https://www.youtube.com/watch?v=8m6hHRlKwxY
    https://marketplace.visualstudio.com/items?itemName=Snakemake.snakemake-lang
    https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer
    
    


    PIPELINE
    Define Pipeline Objectives: Start by clearly defining the objectives of your pipeline. What specific analyses or tasks do you want to perform on the RNA-seq data? This could include quality control, read alignment, differential expression analysis, functional annotation, etc.

Data Preparation and Preprocessing:

Download Raw Data: Obtain the raw RNA-seq data from a sequencing facility or public repository (e.g., NCBI SRA, EBI ArrayExpress).
Quality Control (QC): Assess the quality of raw sequencing reads using tools like FastQC or MultiQC. Identify any issues such as adapter contamination or low-quality bases.
Adapter Trimming and Quality Filtering: Trim adapter sequences and filter out low-quality reads using tools like Trimmomatic or Cutadapt.
Read Alignment:

Reference Genome: Download or obtain a reference genome for the organism you are studying.
Read Alignment: Map the preprocessed reads to the reference genome using an aligner such as HISAT2, STAR, or Bowtie.
Post-Alignment QC: Assess the quality of read alignments using tools like SAMtools or Qualimap.
Quantification:

Gene-Level Quantification: Estimate gene expression levels from the aligned reads using tools like featureCounts or HTSeq.
Transcript-Level Quantification (Optional): If interested in isoform-level expression, use tools like Salmon or Kallisto for pseudoalignment-based quantification.
Differential Expression Analysis:

Experimental Design: Define the experimental groups and conditions for differential expression analysis.
DE Analysis: Perform differential expression analysis using tools like DESeq2, edgeR, or limma-voom.
Visualization: Generate plots such as volcano plots, MA plots, and heatmaps to visualize differentially expressed genes.
Functional Analysis and Interpretation:

Gene Set Enrichment Analysis (GSEA): Identify enriched biological pathways or gene ontology terms associated with differentially expressed genes using tools like clusterProfiler or gProfiler.
Visualization: Visualize enrichment results using tools like EnrichmentMap or ggplot2.
Documentation and Reporting:

Pipeline Documentation: Provide clear documentation for each step of the pipeline, including input data requirements, software dependencies, parameter settings, and output formats.
Results Interpretation: Write a summary of the analysis results, including key findings, significant genes/pathways, and potential biological implications.
Pipeline Implementation with Snakemake:

Write a Snakefile defining the rules and dependencies for each step of the pipeline.
Use Snakemake's wildcard and input/output file matching capabilities to dynamically generate rules.
Define configuration files to specify input data, parameters, and other settings.
Test the pipeline with a small subset of data to ensure correctness and efficiency.
Execution and Optimization:

Run the pipeline on a computing cluster or cloud environment to utilize parallel processing capabilities.
Monitor resource usage and optimize pipeline performance by adjusting rule concurrency, memory allocation, and other parameters.
Debug any errors or issues that arise during pipeline execution.
Validation and Benchmarking:

Validate the pipeline results by comparing with known results or experimental validation.
Benchmark the pipeline performance in terms of runtime, memory usage, and accuracy against alternative methods or tools.


# Managing environments with conda and mamba
Create an enviroment named thierno_env that has no packages installed in it
    mamba create --name thierno_env

Create an environment named myenv with the spicified python version installed in it
    mamba create -n myenv python=3.9

Create an environment named myenv with the package named scipy installed in it
    mamba create -n myenv scipy 

Create an environment named myenv with a specific version of python and multiple packages installed
    mamba create -n myenv python=3.9 scipy=0.17.3 astroid babel

Create an environment from an environment file where the name of the env is defined in the env file
    mamba env create -f environment.yml

Create an environment from an environment file where the name of the env is not defined in the env file
    mamba env create --name nbd --file environment.yaml

To see the list of environments
    mamba env list

Installing packages in the environment myenv
    mamba install -n myenv scipy=0.17.3 

Activate the conda base environment, if not activated during the installation
    mamba activate base

Activate an environment with mamba
    mamba activate env_name
    
Deactivate the current active environment with mamba    
    mamba deactivate

Updating an environment
    mamba env update --file environment.yml --prune

Cloning an environment
    mamba create --name myclone --clone myenv

Removing an environment
    mamba remove --name myenv --all

conda create --prefix ./envs
conda activate ./envs

mamba list -n myenv
mamba list
mamba list -n myenv scipy

# Snakemake 
    This part of the documentation describes the snakemake executable. Snakemake is primarily a command-line tool, so the snakemake executable is the primary way to execute, debug, and visualize workflows.
    Snakemake caches source files for performance and reproducibility.
    If you want to change the CACHE location on a unix/linux system, you can define an override path via the environment variable XDG_CACHE_HOME. When running jobs in parallel, 
    snakemake can automatically determine which part of the workflow can be executed in parallel.
    
    snakemake --help
    snamake --cores 1       > execute the workflow by using 1 core
    snakemake --cores 4     > execute the workflow by using up to 4 cores
    snakemake --cores 4 --set-threads myrule=2
    snakemake --cores       > execute the workflow by using up to the number of available CPU cores in  your system
    -s > to specify the snakefile 
    -n > dry run is useful to test if the workflow is defined properly and to estimate the amount of needed computation.
    








# csc522-bioinformatics-python-R
I am building a bioinformatics pipeline with python, R and snakemake

snakemake best practice > https://snakemake.readthedocs.io/en/stable/snakefiles/best_practices.html
uri vpn                 > https://its.uri.edu/itsec/vpn-enrollment/
snakemake-tutorial      > https://snakemake.readthedocs.io/en/stable/tutorial/basics.html                  

Installation && setup 
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

    Activate the conda base environment, if not activated during the installation
    conda activate base

    Create an environment with the required software
    mamba env create --name snakemake-tutorial --file environment.yaml






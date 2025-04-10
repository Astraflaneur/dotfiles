#!/bin/bash

# Download and install Miniconda
cd ~
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda3
rm miniconda.sh

# Initialize Conda
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
conda init

# Install wandb CLI
pip install --upgrade pip
pip install wandb

echo "Miniconda and wandb installed! You may need to restart your shell."


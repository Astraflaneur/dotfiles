#!/bin/bash
#/////////////////////////////////////////////////////////////////////////////////////
#//                 Astraflaneur – Base Conda Environment Bootstrap                //
#//                          By Sagar P. Barad | 2025                              //
#/////////////////////////////////////////////////////////////////////////////////////
#//                                                                                 //
#//  Script:     create_base_env.sh                                                 //
#//  Created:    10 April 2025                                                      //
#//  Platform:   Linux / Unix-like                                                  //
#//  Purpose:    Creates a base ML environment with PyTorch, W&B, etc.              //
#/////////////////////////////////////////////////////////////////////////////////////


ENV_NAME=$1
shift
EXTRA_PACKAGES=$@

if [ -z "$ENV_NAME" ]; then
  echo "Usage: ./create_env.sh <env_name> [extra_packages...]"
  exit 1
fi

# Activate conda
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"

# Create environment
conda create -y -n "$ENV_NAME" python=3.12.9
conda activate "$ENV_NAME"

# Basic ML/Scientific stack
conda install -y numpy scipy matplotlib scikit-learn pandas

pip3 install scienceplots wandb  torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126b

# Install extra packages passed by user
if [ ! -z "$EXTRA_PACKAGES" ]; then
  pip install $EXTRA_PACKAGES
fi

echo "Environment '$ENV_NAME' created with base packages and: $EXTRA_PACKAGES"


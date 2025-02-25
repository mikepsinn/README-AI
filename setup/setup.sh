#!/bin/bash

# Clone the repository
#echo "Cloning the README-AI repository..."
#git clone https://github.com/eli64s/README-AI.git
#cd README-AI

# Welcome message
echo "Welcome to the README-AI environment setup script!"

# Check if conda is installed
if ! command -v conda &> /dev/null; then
    echo "Conda is not installed. Please install Anaconda or Miniconda and rerun the script."
    exit 1
fi

# Check for Python installation and required version (3.7+)
echo "Checking for Python 3.7 or higher..."
python_version=$(python3 -c 'import sys; print("{}.{}".format(sys.version_info[0], sys.version_info[1]))' 2>/dev/null)

if [ $? -ne 0 ]; then
    echo "Python 3 is not installed. Please install Python 3.7 or higher and rerun the script."
    exit 1
fi

IFS='.' read -ra version_parts <<< "$python_version"
major=${version_parts[0]}
minor=${version_parts[1]}

if [ "$major" -lt 3 ] || ([ "$major" -eq 3 ] && [ "$minor" -lt 7 ]); then
    echo "Please upgrade to Python 3.7 or higher and rerun the script."
    exit 1
fi

echo "Python version is compatible."

# Create a new conda environment named 'readmeai'
echo "Creating a new conda environment named 'readmeai' with Python 3.8..."
conda env create -f setup/environment.yaml

# Activate the conda environment
echo "Activating the 'readmeai' environment..."
eval "$(conda shell.bash hook)"
conda activate readmeai

# Add the Python path from the active conda environment to PATH
echo "Adding Python path to the PATH environment variable..."
export PATH="$(conda info --base)/envs/readmeai/bin:$PATH"

# Install the required packages using pip
echo "Installing required packages from 'requirements.txt'..."
pip install -r requirements.txt

# Download the spaCy model
python -m spacy download en_core_web_sm

# Deactivate the conda environment
conda deactivate

echo "Setup complete. Use 'conda activate readmeai' to activate the environment."
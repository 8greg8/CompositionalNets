#!/bin/bash

envname=compnets

echo ""
python -c 'print("#"*80)'
echo "Configuring conda environment <$envname>"


conda=$HOME/anaconda3/etc/profile.d/conda.sh
. $conda

# Crate env
conda create -n $envname --no-default-packages python=3.6

# Add env_vars
conda activate $envname
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
mkdir -p $CONDA_PREFIX/etc/conda/deactivate.d
ln -s $(pwd)/conda/activate.d/env_vars.sh $CONDA_PREFIX/etc/conda/activate.d/
ln -s $(pwd)/conda/deactivate.d/env_vars.sh $CONDA_PREFIX/etc/conda/deactivate.d/
conda deactivate

# Install packages
conda activate $envname

# Install dependencies
pip install matplotlib==3.1.1 tqdm==4.36.1 numpy==1.16.5 scipy==1.2.0 opencv-python==4.1.1.26 pillow==7.1.0
pip install torch==1.2.0 torchvision==0.4.0 -f https://download.pytorch.org/whl/torch_stable.html

# Install pycocotools
cd /data/src/computer_vision/cocoapi/PythonAPI
make install
cd -


echo "Conda environment <$envname> configured"
python -c 'print("#"*80)'

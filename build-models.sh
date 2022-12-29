#!/bin/zsh

CONDA_ENV = "gauss"


function init_conda_env(){
    CONDA_BASE=$(conda info --base)
    source $CONDA_BASE/etc/profile.d/conda.sh
}


function create_env() {
    conda create -n $CONDA_ENV python=3.8 -y
    init_conda_env
    conda activate $CONDA_ENV
}


function install_deps() {
    git clone "https://github.com/apple/ml-stable-diffusion.git"
    cd "ml-stable-diffusion"
    pip install -r requirements.txt
    pip install numpy==1.23
    pip install torch==1.12.1

}


set -xeo pipefail

DESTINATION="compiled-models"

build() {
  local model_version
  model_version="$1"
  local dest
  dest="$2"
  mkdir -p "$DESTINATION"
  python -m python_coreml_stable_diffusion.torch2coreml \
    --convert-unet --convert-text-encoder --convert-vae-decoder --convert-safety-checker \
    --model-version "$model_version" \
    --bundle-resources-for-swift-cli \
    --chunk-unet \
    -o "../$DESTINATION/$dest"
  echo "{build,$dest}"
  mv "../$DESTINATION/$dest/Resources/*" "../$DESTINATION/$dest"
}

create_env

conda activate $CONDA_ENV

install_deps

build stabilityai/stable-diffusion-2-base sd2-base
build CompVis/stable-diffusion-v1-4       sd1.4
build runwayml/stable-diffusion-v1-5      sd1.5

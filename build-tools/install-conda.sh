#!/bin/sh

set -e
if [ ! -x "$HOME/miniconda/bin/conda" ]; then
    rm -rf "$HOME/miniconda"
    wget --no-verbose https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
    bash miniconda.sh -b -p "$HOME/miniconda"
fi
export PATH="$HOME/miniconda/bin:$PATH"
conda config --set always_yes yes --set changeps1 no
conda update -q conda
if [ ! -d "$HOME/miniconda/envs/lkpy-test" ]; then
    conda create -q -n lkpy-test python="$TRAVIS_PYTHON_VERSION"
fi
conda install -q -n lkpy-test pandas dask
conda install -q -n lkpy-test pytest pytest-arraydiff pytest-cov pylint invoke
conda update -q -n lkpy-test --all

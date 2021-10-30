#!/bin/bash

pyenv init
pyenv install 3.8.0
pyenv virtualenv 3.8.0 dnn
pyenv init dnn
pip install -r requirements.txt

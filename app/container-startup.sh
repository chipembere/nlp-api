#!/bin/bash
if [[ -d "models/ProsusAI/finbert" ]] ; then
    echo "Models exists."
else 
    echo "No models."
    python3 utils/get_models.py
    echo "Model downloaded."
fi

if [ "$1" = "dev" ]; then
    echo "Dev enviroment request."
    python3 main.py
else
    echo "Prod enviroment request."
    python3 main.py
fi
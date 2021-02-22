#!/bin/bash
if [[ -d "distilbert-base-uncased-finetuned-sst-2-english" ]] ; then
    echo "Model exists."
else 
    echo "Model does not exist."
    python3 get_models.py
    echo "Model downloaded."
fi

# ["uvicorn", "main:api", "--host", "0.0.0.0", "--port", "8080"]
python3 main.py
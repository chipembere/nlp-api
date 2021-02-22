def get_model():
    from transformers import AutoTokenizer, AutoModelForSequenceClassification

    tokenizer = AutoTokenizer.from_pretrained("distilbert-base-uncased-finetuned-sst-2-english")  
    model = AutoModelForSequenceClassification.from_pretrained("distilbert-base-uncased-finetuned-sst-2-english")

    tokenizer.save_pretrained("distilbert-base-uncased-finetuned-sst-2-english")
    model.save_pretrained("distilbert-base-uncased-finetuned-sst-2-english")

get_model()
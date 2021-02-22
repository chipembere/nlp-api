def main():
    """ Downloads and saves nlp model and tokenizer in the same directory. """
    from transformers import AutoTokenizer, AutoModelForSequenceClassification

    tokenizer = AutoTokenizer.from_pretrained("distilbert-base-uncased-finetuned-sst-2-english")  
    model = AutoModelForSequenceClassification.from_pretrained("distilbert-base-uncased-finetuned-sst-2-english")

    tokenizer.save_pretrained("distilbert-base-uncased-finetuned-sst-2-english")
    model.save_pretrained("distilbert-base-uncased-finetuned-sst-2-english")

if __name__ == '__main__':
    main()

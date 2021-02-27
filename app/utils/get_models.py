def main():
    """ Downloads and saves nlp model and tokenizer in the same directory. """
    import os
    from transformers import AutoTokenizer, AutoModelForSequenceClassification

    tokenizer = AutoTokenizer.from_pretrained("ProsusAI/finbert")
    model = AutoModelForSequenceClassification.from_pretrained(
                                        "ProsusAI/finbert")
    pwd = os.getcwd()
    tokenizer.save_pretrained(f"{pwd}/models/ProsusAI/finbert")
    model.save_pretrained(f"{pwd}/models/ProsusAI/finbert")


if __name__ == '__main__':
    main()

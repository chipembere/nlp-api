def main():
    """ Downloads and saves nlp model and tokenizer in the same directory. """
    from transformers import AutoTokenizer, AutoModelForSequenceClassification

    tokenizer = AutoTokenizer.from_pretrained("ProsusAI/finbert")
    model = AutoModelForSequenceClassification.from_pretrained(
                                        "ProsusAI/finbert")

    tokenizer.save_pretrained("models/ProsusAI/finbert")
    model.save_pretrained("models/ProsusAI/finbert")


if __name__ == '__main__':
    main()

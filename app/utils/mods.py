from transformers import AutoTokenizer, AutoModelForSequenceClassification,\
                        pipeline


class MODS:
    def __init__(self, mod):
        self.mod = mod
        self.tokenizer = AutoTokenizer.from_pretrained(f"models/{self.mod}")
        self.model = AutoModelForSequenceClassification.from_pretrained(
            f"models/{self.mod}")

    def pipeline_sent(self, text: str):
        classifier = pipeline('sentiment-analysis', model=self.model,
                              tokenizer=self.tokenizer)
        result = classifier(text)[0]['label']
        return result

import os
from transformers import AutoTokenizer, AutoModelForSequenceClassification,\
                        pipeline

pwd = os.getcwd()


class MODS:
    def __init__(self, mod):
        self.mod = mod
        self.tokenizer = AutoTokenizer.from_pretrained(
                                f"{pwd}/models/{self.mod}")
        self.model = AutoModelForSequenceClassification.from_pretrained(
            f"{pwd}/models/{self.mod}")

    def pipeline_sent(self, text: str):
        classifier = pipeline('sentiment-analysis', model=self.model,
                              tokenizer=self.tokenizer)
        result = classifier(text)[0]['label']
        return result

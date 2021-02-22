from transformers import AutoTokenizer, AutoModelForSequenceClassification, pipeline

class MODS:
    def __init__(self):
        self.tokenizer = AutoTokenizer.from_pretrained("distilbert-base-uncased-finetuned-sst-2-english")
        self.model = AutoModelForSequenceClassification.from_pretrained("distilbert-base-uncased-finetuned-sst-2-english")

    def pipeline_sent(self,text:str):
        classifier = pipeline('sentiment-analysis', model=self.model, tokenizer=self.tokenizer)
        result = classifier(text)[0]['label']
        return result
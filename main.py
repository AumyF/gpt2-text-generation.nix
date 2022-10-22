import os
from transformers import T5TokenizerFast, GPT2LMHeadModel

PREFIX_TEXT = "こんなときに貴女は"

model_path = os.environ['MODELPATH']

tokenizer = T5TokenizerFast.from_pretrained(model_path)
tokenizer.do_lower_case = True

model = GPT2LMHeadModel.from_pretrained(model_path)


input = tokenizer.encode(PREFIX_TEXT, return_tensors="pt")
output = model.generate(input, do_sample=True, max_length=140, num_return_sequences=1)

for out in (tokenizer.batch_decode(output)):
    print(out)

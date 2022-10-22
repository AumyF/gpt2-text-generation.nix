import os
from transformers import T5TokenizerFast, GPT2LMHeadModel, pipeline

max_length = os.environ.get('MAX_LENGTH', 140)

prefix_text = os.environ.get('PREFIX_TEXT', "風をずっと待っているの 身軽になるための言葉自体が重くて歩けないわ") # Inaba Kumori - Kazemachigusa

# provided from nix-shell
model_path = os.environ['MODELPATH']

tokenizer = T5TokenizerFast.from_pretrained(model_path)
model = GPT2LMHeadModel.from_pretrained(model_path)

generator = pipeline('text-generation', model = model, tokenizer = tokenizer)
generator.model.config.pad_token_id = generator.model.config.eos_token_id
outputs = generator(prefix_text, max_length=max_length)

for output in outputs:
    print(output)

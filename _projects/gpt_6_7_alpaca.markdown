---
layout: page
title: GPT-6.7B-Alpaca
description: a low-rank adapter for an instruction-tuned 6.7B-parameter GPT3-style language model
img: https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Alpaca_headshot.jpg/800px-Alpaca_headshot.jpg
importance: 993
category: work
---

# Model Card

We provide a low-rank adapter for an instruction-tuned 6.7B-parameter GPT3-style language model.

Example instruction:

```
Write a list of things I need to do to plan a watch party for Game 4 of the Knicks-Cavs playoff series.
```

Corresponding response from the model:

```
1. Find out where the game will be played and purchase tickets.
2. Decide on food, drinks, decorations, and entertainment.
3. Plan the route to get there.
4. Arrange transportation.
5. Organize games and activities for guests.
6. Make sure everyone has their tickets.
7. Set up the venue.
8. Prepare for the event.
9. Clean up after the event.
10. Celebrate with friends and family.
```

## Quickstart

Setting up the model using `transformers` and `peft`:

```python
from peft import PeftModel
from transformers import AutoTokenizer, AutoModelForCausalLM

tokenizer = AutoTokenizer.from_pretrained("cerebras/Cerebras-GPT-6.7B")
tokenizer.pad_token_id = 0

model = AutoModelForCausalLM.from_pretrained(
    "cerebras/Cerebras-GPT-6.7B",
    load_in_8bit=True,
    device_map="auto",
)
model = PeftModel.from_pretrained(
  model,
  "lucasmccabe-lmi/GPT-6.7B-CleanedAlpaca-1"
)
```

## Prompting

For instructions that **do not** require extraneous inputs, the recommended prompt is:

```
Below is an instruction that describes a task. Write a response that appropriately completes the request.


### Instruction:

< -- instruction goes here --- >

### Response:
```

For instructions that **do** require extraneous inputs, the recommended prompt is:

```
Below is an instruction that describes a task. Write a response that appropriately completes the request.


### Instruction:

< -- instruction goes here -- >

### Input:

< -- extraneous input goes here -- >

### Response:
```

Since the model performs [causal language modeling](https://huggingface.co/docs/transformers/tasks/language_modeling), the model's response to the prompt is the text completing the sequence beginning with the prompt.


## Instruction-Tuning

This model was instruction-tuned on [a cleaned version of the Stanford Alpaca dataset](https://github.com/gururise/AlpacaDataCleaned), consisting of 52k post-processed instruction-input-output triplets derived from OpenAI's `text-davinci-003`.

- **Epochs**: 3
- **Batch size**: 128
- **Cutoff length**: 512
- **Learning rate**: 2e-5
- **LoRA _r_**: 4
- **LoRA _alpha_**: 16
- **LoRA _dropout_**: 0.05
- **LoRA target modules**: `c_attn`
- **Dataset**: [yahma/alpaca-cleaned](https://huggingface.co/datasets/yahma/alpaca-cleaned)
- **License**: The instruction-tuning data is subject to the [Creative Commons 4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Base Model

This model was instruction-tuned from a 6.7B variant from the Cerebras-GPT family. These models were pre-trained to the ["Chinchilla-optimal"](https://arxiv.org/abs/2203.15556) 20*6.7B tokens from [EleutherAI/The Pile](https://huggingface.co/datasets/EleutherAI/the_pile).

- **Repository:** [cerebras/Cerebras-GPT-6.7B](https://huggingface.co/cerebras/Cerebras-GPT-6.7B)
- **Paper:** [arxiv:2304.03208](https://arxiv.org/abs/2304.03208)
- **License**: The base model is subject to the Apache 2.0 license.
- **Model type**: Transformer-based Language Model

## Software

We used [LMI's](https://huggingface.co/lmiconsulting) internal `liger` library, which is built on `PyTorch` and the excellent Hugging Face stack (`transformers`, `accelerate`, etc.).

## Licensing Information

We release this adapter under the [Creative Commons NonCommercial (CC BY-NC 4.0)](https://creativecommons.org/licenses/by-nc/4.0/) license.

## Author

- [lucasmccabe-lmi](https://lucasmccabe.github.io/)

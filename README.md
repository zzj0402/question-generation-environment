# question-generation-environment
https://github.com/microsoft/unilm

## Run

```bash
docker run -it --rm --runtime=nvidia --privileged zzj0402/unilm-question-generation-environment bash
```

## Decoding

```bash
python biunilm/decode_seq2seq.py --bert_model bert-large-cased --new_segment_ids --mode s2s \
  --input_file ${DATA_DIR}/test.pa.tok.txt --split ${EVAL_SPLIT} --tokenized_input \
  --model_recover_path ${MODEL_RECOVER_PATH} \
  --max_seq_length 512 --max_tgt_length 48 \
  --batch_size 16 --beam_size 1 --length_penalty 0
```
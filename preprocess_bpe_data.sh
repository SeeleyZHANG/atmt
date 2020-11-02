# Generate code files
echo 'Generating code files'
subword-nmt learn-bpe --input bpe/preprocessed_data/train.en -o bpe/preprocessed_data/code.BPE.en
subword-nmt learn-bpe --input bpe/preprocessed_data/train.de -o bpe/preprocessed_data/code.BPE.de

# Generate vocabulary
echo 'Generating vocabulary'
subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.en < bpe/preprocessed_data/train.en | subword-nmt get-vocab > bpe/preprocessed_data/vocab.en
subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.de < bpe/preprocessed_data/train.de | subword-nmt get-vocab > bpe/preprocessed_data/vocab.de

# re-apply byte pair encoding with vocabulary filter
echo 're-apply byte pair encoding with vocabulary filter'
subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.en  --vocabulary bpe/preprocessed_data/vocab.en --vocabulary-threshold 50 < bpe/preprocessed_data/train.en > bpe/preprocessed_data/train.BPE.en
subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.de  --vocabulary bpe/preprocessed_data/vocab.de --vocabulary-threshold 50 < bpe/preprocessed_data/train.de > bpe/preprocessed_data/train.BPE.de

subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.en  --vocabulary bpe/preprocessed_data/vocab.en --vocabulary-threshold 50 < bpe/preprocessed_data/valid.en > bpe/preprocessed_data/valid.BPE.en
subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.de  --vocabulary bpe/preprocessed_data/vocab.de --vocabulary-threshold 50 < bpe/preprocessed_data/valid.de > bpe/preprocessed_data/valid.BPE.de

subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.en  --vocabulary bpe/preprocessed_data/vocab.en --vocabulary-threshold 50 < bpe/preprocessed_data/test.en > bpe/preprocessed_data/test.BPE.en
subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.de  --vocabulary bpe/preprocessed_data/vocab.de --vocabulary-threshold 50 < bpe/preprocessed_data/test.de > bpe/preprocessed_data/test.BPE.de

subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.en  --vocabulary bpe/preprocessed_data/vocab.en --vocabulary-threshold 50 < bpe/preprocessed_data/tiny_train.en > bpe/preprocessed_data/tiny_train.BPE.en
subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.de  --vocabulary bpe/preprocessed_data/vocab.de --vocabulary-threshold 50 < bpe/preprocessed_data/tiny_train.de > bpe/preprocessed_data/tiny_train.BPE.de


# extract vocabulary for use by NN
echo 'Starting preprocess.py'
python preprocess.py --target-lang en --source-lang de --dest-dir bpe/prepared_data/ --train-prefix bpe/preprocessed_data/train.BPE --valid-prefix bpe/preprocessed_data/valid.BPE --test-prefix bpe/preprocessed_data/test.BPE --tiny-train-prefix bpe/preprocessed_data/tiny_train.BPE --threshold-src 1 --threshold-tgt 1 --num-words-src 4000 --num-words-tgt 4000



subword-nmt apply-bpe -c bpe/preprocessed_data/code.BPE.en --vocabulary bpe/preprocessed_data/vocab.en --vocabulary-threshold 50 < bpe/raw_data/test.en > bpe/raw_data/test_bpe.en



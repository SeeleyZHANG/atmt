sudo pip install subword-nmt    #download the package for bpe
bash preprocess_bpe_data.sh



python train.py --batch-size 100
python translate.py --data bpe/prepared_data/
bash postprocess.sh model_translations.txt model_translations.out en 
cat model_translations.out | sacrebleu bpe/raw_data/test.en
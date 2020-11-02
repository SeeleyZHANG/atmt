
# batch_size = 200, lr = 0.003(the original learning rate)
python train.py --batch-size 200 --data baseline/prepared_data/
python translate.py --data baseline/prepared_data/
bash postprocess.sh model_translations.txt model_translations.out en 
bash postprocess.sh model_translations.txt model_translations.out en 
cat model_translations.out | sacrebleu baseline/raw_data/test.en
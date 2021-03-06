
# batch_size = 100, lr = 0.03
python train.py --lr 0.03 --batch-size 100 --data baseline/prepared_data/
python translate.py --data baseline/prepared_data/
bash postprocess.sh model_translations.txt model_translations.out en 
bash postprocess.sh model_translations.txt model_translations.out en 
cat model_translations.out | sacrebleu baseline/raw_data/test.en
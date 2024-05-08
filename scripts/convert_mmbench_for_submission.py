import os
import json
import argparse
import pandas as pd

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--annotation-file", type=str, required=True)
    parser.add_argument("--result-dir", type=str, required=True)
    parser.add_argument("--upload-dir", type=str, required=True)
    parser.add_argument("--experiment", type=str, required=True)

    return parser.parse_args()

def extract_answer(prediction_text):
    valid_answers = ['A)', 'B)', 'C)', 'D)']
    if prediction_text.startswith(tuple(valid_answers)):
        return prediction_text[:1]
    else:
        raise ValueError(f"Invalid prediction: {prediction_text}")

if __name__ == "__main__":
    args = get_args()

    df = pd.read_table(args.annotation_file)
    cur_df = df.copy()
    cur_df = cur_df.drop(columns=['hint', 'category', 'source', 'image', 'comment', 'l2-category'])
    cur_df.insert(6, 'prediction', None)
    correct = 0
    count = 0
    for pred in open(os.path.join(args.result_dir, f"{args.experiment}.jsonl")):
        pred = json.loads(pred)
        y_pred = extract_answer(pred['text'])
        cur_df.loc[df['index'] == pred['question_id'], 'prediction'] = y_pred
        count += 1
        correct += y_pred == cur_df.loc[df['index'] == pred['question_id'], 'answer'].item()
        
    cur_df.to_excel(os.path.join(args.upload_dir, f"{args.experiment}.xlsx"), index=False, engine='openpyxl')

    print(f"Accuracy: {correct/count}")

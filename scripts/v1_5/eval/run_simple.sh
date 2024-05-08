#!/bin/bash
model_path="LanguageBind/Video-LLaVA-7B"
root_dir="/path/to/your/cloned/repo/of/Video-Bench"
# NOTE: UNCOMMENT THE DATASET YOU WANT TO EVALUATE (ONLY ONE AT A TIME) (NOTE video_dir AND gt_file_question)

# output_name="v3-msvd"
# video_dir="${root_dir}/Eval_video/MSVD"
# gt_file_question="${root_dir}/Eval_QA/MSVD_QA_new.json"

# output_name="v3-msrvtt"
# video_dir="${root_dir}/Eval_video/MSRVTT"
# gt_file_question="${root_dir}/Eval_QA/MSRVTT_QA_new.json"

# output_name="v3-tgif"
# video_dir="${root_dir}/Eval_video/TGIF"
# gt_file_question="${root_dir}/Eval_QA/TGIF_QA_new.json"

# output_name="v3-activitynet" # mmco: unref short failure
# video_dir="${root_dir}/Eval_video/ActivityNet"
# gt_file_question="${root_dir}/Eval_QA/ActivityNet_QA_new.json"

# output_name="v3-youcook2" # mmco: unref short failure
# video_dir="${root_dir}/Eval_video/Youcook2"
# gt_file_question="${root_dir}/Eval_QA/Youcook2_QA_new.json"

# output_name="v3-ucfcrime"
# video_dir="${root_dir}/Eval_video/Ucfcrime"
# gt_file_question="${root_dir}/Eval_QA/Ucfcrime_QA_new.json"

# output_name="v3-mot"
# video_dir="${root_dir}/Eval_video/MOT"
# gt_file_question="${root_dir}/Eval_QA/MOT_QA_new.json"

# output_name="v3-tvqa"
# video_dir="${root_dir}/Eval_video/TVQA"
# gt_file_question="${root_dir}/Eval_QA/TVQA_QA_new.json"

# output_name="v3-mvqa"
# video_dir="${root_dir}/Eval_video/MV"
# gt_file_question="${root_dir}/Eval_QA/MV_QA_new.json"

# output_name="v3-nbaqa" # mmco: unref short failure
# video_dir="${root_dir}/Eval_video/NBA"
# gt_file_question="${root_dir}/Eval_QA/NBA_QA_new.json"

# output_name="v3-driving-decision-making"
# video_dir="${root_dir}/Eval_video/Driving-decision-making"
# gt_file_question="${root_dir}/Eval_QA/Driving-decision-making_QA_new.json"

# output_name="v3-driving-exam"
# video_dir="${root_dir}/Eval_video/Driving-exam"
# gt_file_question="${root_dir}/Eval_QA/Driving-exam_QA_new.json"

output_name="v3-sqa3d"
video_dir="${root_dir}/Eval_video/SQA3D"
gt_file_question="${root_dir}/Eval_QA/SQA3D_QA_new.json"


# DON'T COMMENT OUT BELOW
gt_file_answers="${root_dir}/Eval_QA/ANSWER.json" # https://huggingface.co/spaces/LanguageBind/Video-Bench/blob/main/file/ANSWER.json
output_dir="${root_dir}/Eval_QA/predictions" # feel free to change this to any directory you want

python videollava/eval/video/run_inference_video_qa.py \
    --model_path ${model_path} \
    --video_dir ${video_dir} \
    --gt_file_question ${gt_file_question} \
    --gt_file_answers ${gt_file_answers} \
    --output_dir ${output_dir} \
    --output_name ${output_name}

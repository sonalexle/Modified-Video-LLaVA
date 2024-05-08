# Running Video-LLaVA on Video-Bench and some image-text VQA datasets

Original repos: [Video-LLaVA (Lin et al., 2023)](https://github.com/PKU-YuanGroup/Video-LLaVA) and [Video-Bench (Ning et al., 2023)](https://github.com/PKU-YuanGroup/Video-Bench)

## What is it?

* "The benchmark comprises 10 meticulously crafted tasks, evaluating the capabilities of Video-LLMs across three distinct levels:

* __Video-exclusive Understanding__

* __Prior Knowledge-based Question-Answering__

* __and Comprehension and Decision-making.__"

* Consists of 13 datasets, all in multiple-choice QA format

* Some open-ended datasets converted to QA format (e.g. YouCook2)

## Prerequisites, setup, etc.

* In the same directory, clone the [Video-LLaVA](https://github.com/PKU-YuanGroup/Video-LLaVA) repo and the [Video-Bench](https://github.com/PKU-YuanGroup/Video-Bench) repo. For Video-LLaVA, you should clone this repo instead of the original repo.

* Install the prerequisite Python packages for Video-LLaVA by following [these steps](https://huggingface.co/datasets/LanguageBind/Video-Bench).

* Install the prerequisite Python packages for Video-Bench by following [these steps](https://github.com/PKU-YuanGroup/Video-Bench?tab=readme-ov-file#-evaluation).

* Download the video-text datasets from [this Hugging Face Hub repo](https://huggingface.co/datasets/LanguageBind/Video-Bench), put the zips into this directory `Video-Bench/Eval_video`, then unzip each.

* Download the Video-Bench ground-truth answers in [this file](https://huggingface.co/spaces/LanguageBind/Video-Bench/blob/main/file/ANSWER.json). Put the file inside `Video-Bench/Eval_video` too. Note that this file is hidden on their HuggingFace Spaces!

* For the image-text VQA datasets (not part of the Video-Bench benchmark), follow [this README](https://github.com/PKU-YuanGroup/Video-LLaVA/blob/main/TRAIN_AND_VALIDATE.md) to download them. Should be straightforward to download at least some of them. The downloaded datasets should be put in `Video-LLaVA/eval/<their-directory-structure>`.

## Example run command

* These points only apply if you cloned this repo to run Video-LLaVA.

* There are some python files that start with `import sys; sys.path.append(/path/to/your/cloned/repo/of/Video-LLaVA)`. Remove all such lines or replace with your path.

* In `Video-LLaVA/scripts/v1_5/eval/run_simple.sh`, replace the `root_dir` with your path as instructed.

* For video-text evals, run `bash scripts/v1_5/eval/run_simple.sh` as instructed in the `run_simple.sh` file. If you do not change `output_dir`, head there and you can find the `json` files containing the predicted (key `pred`) and ground-truth answers (key `answer`). The first letter of `pred` should always be one of the answer letters (e.g. A, B, C, D). You can compute the MCQA accuracy based on this.

* For image-text evals, you need to run each script separately with this command `bash scripts/v1_5/eval/eval_image_*`. The inference code will save a file with predictions in the directory of the dataset you downloaded earlier. See [the original README](https://github.com/PKU-YuanGroup/Video-LLaVA/blob/main/TRAIN_AND_VALIDATE.md) for more info. Note, that README tells you to upload your predictions to their servers for eval. I did not do this, I only ran the inference code to generate predictions.

## Notes

* The original Video-Bench code generates open-ended answers, which need to be matched with ground-truths. They used `gpt-3.5-turbo` for this.

* To circumvent using GPT for eval, we follow [MVBench's approach](https://github.com/OpenGVLab/Ask-Anything/blob/main/video_chat2/mvbench.ipynb) (Li et al. 2024) and wrap each answer letter with parenthesis, e.g. (A) (B) (C), then append the final prompt with " Best option: (". This ensures (with high probability) the first token the model generates is one of the answer letters. This approach works well for Video-LLaVA.

* Video-Bench codebase only provides the dataset (video archives and question-answer jsons) and a bad prompt template

* I also changed the prompt template of Video-Bench when running Video-LLaVA. Now the template is more similar to the one used by MVBench.

* Overall, pretty easy to set up and run (need to have system video libraries like ffmpeg etc.)

* Video-LLaVA codebase (based on LLaVA codebase) provides a pipeline to load videos, preparing the prompt, code to generate model predictions (huggingface .generate)

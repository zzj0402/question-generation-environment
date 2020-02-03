FROM pytorch/pytorch:1.1.0-cuda10.0-cudnn7.5-devel

ENV TZ=Pacific/Auckland
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

RUN apt-get install -y git-all vim wget ssh htop unzip

RUN git clone -q https://github.com/NVIDIA/apex.git
RUN cd apex && git reset --hard 1603407bf49c7fc3da74fceb6a6c7b47fece2ef8 && python setup.py install --user --cuda_ext --cpp_ext

RUN pip install --user tensorboardX six numpy tqdm path.py pandas scikit-learn lmdb pyarrow py-lz4framed methodtools py-rouge pyrouge nltk
RUN python -c "import nltk; nltk.download('punkt')"

RUN pip install -e git://github.com/Maluuba/nlg-eval.git#egg=nlg-eva

WORKDIR /root/
RUN git clone https://github.com/microsoft/unilm.git
RUN cd unilm/src && pip install --user --editable .

RUN pip install gdown

# Processed data
RUN gdown --id 11E3Ij-ctbRUTIQjueresZpoVzLMPlVUZ -O qg-data.zip

# Fine-Tuned Checkpoint
RUN gdown --id 1JN2wnkSRotwUnJ_Z-AbWwoPdP53Gcfsn -O qg-model.zip

# Test Preparation
RUN unzip qg-data.zip && rm qg-data.zip
ENV DATA_DIR=/root/test
RUN unzip qg-model.zip && rm qg-model.zip
ENV MODEL_RECOVER_PATH=/root/qg_model.bin
ENV EVAL_SPLIT=test
ENV PYTORCH_PRETRAINED_BERT_CACHE=/root/bert-cased-pretrained-cache
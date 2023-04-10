FROM gitpod/workspace-full

USER gitpod

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

ENV PATH=$HOME/miniconda/bin:$PATH

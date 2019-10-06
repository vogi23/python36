FROM ubuntu:18.04

LABEL maintainer="Christian von Gunten <chrigu@vgbau.ch>"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get clean
RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -y \
	make \
	build-essential  \
    checkinstall \
    libreadline-gplv2-dev \
    libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    zlib1g-dev \
    openssl \
    libncurses5-dev \
	xz-utils \
	libxml2-dev \
	libxmlsec1-dev \
	libffi-dev \
	liblzma-dev 
	
RUN apt-get install -y \	
    python3-dev \
	wget

RUN ln -s /usr/bin/python3 /usr/local/bin/python

# python3-dev does not come with pip bundled
# python3-pip only contains v9.x
# therefore manually install pip3 via get-pip
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

RUN pip install --upgrade pip

RUN python -m pip install jupyter
RUN python -m pip install jupyterlab

RUN python -m pip install bash_kernel
RUN python -m bash_kernel.install

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

ENTRYPOINT ["/bin/bash"]
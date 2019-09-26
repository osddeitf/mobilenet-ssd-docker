FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

RUN apt update && \
    apt -y --no-install-recommends install \
        git \
        nano \
        python-dev python-numpy \
        protobuf-compiler libprotobuf-dev libgoogle-glog-dev libopenblas-dev libopencv-dev libhdf5-serial-dev liblmdb-dev \
        libboost-all-dev

RUN mkdir /ssd
WORKDIR /ssd
RUN git clone https://github.com/weiliu89/caffe -b ssd --depth=1 caffe
RUN git clone https://github.com/osddeitf/MobileNet-SSD --depth=1 mobilenet

WORKDIR /ssd/caffe
COPY Makefile.config .
RUN make clean
RUN make -j
RUN make py

# Set CAFFE_HOME and PYTHONPATH for caffe
COPY .bashrc /root

WORKDIR /ssd

# This dockerfile creates the environmnent to build the conda package in CentOS 7
#

FROM conda/miniconda3-centos7

RUN yum install -y atlas-devel \
    autoconf \
    automake \
    bzip2 \
    curl \
    curl-devel \
    git \
    gcc \
    gcc-c++ \
    gettext-devel \
    gmp-devel \
    graphviz \
    libmpc-devel \
    libtool \
    make \
    mpfr-devel \
    #    openssl \
    #    openssl-devel \
    ncurses-devel \
    patch \
    perl-CPAN \
    perl-devel \
    pkgconfig \
    sox \
    subversion \
    unzip \
    vim \
    wget \
    zlib-devel \
    && conda install -c anaconda python=3.7 \
    && conda install conda-build anaconda-client ninja setuptools pip pyparsing numpy cmake git

# Install protobuf, clif
RUN cd ~ \
    && git clone https://github.com/mxmpl/pykaldi.git \
    && cd pykaldi/tools \
    && ./install_protobuf.sh \
    && ./install_clif.sh


###########################################
# Install CUDA 9
# From: https://gitlab.com/nvidia/cuda/tree/centos7/9.0
###########################################
# RUN NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
#     curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/7fa2af80.pub | sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA && \
#     echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict -
# 
# RUN curl https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo > /etc/yum.repos.d/cuda.repo
# 
# ENV CUDA_VERSION 9.0.176
# ENV CUDA_PKG_VERSION 9-0-$CUDA_VERSION-1
# 
# RUN yum install -y \
#         cuda-cudart-$CUDA_PKG_VERSION && \
#     ln -s cuda-9.0 /usr/local/cuda && \
#     rm -rf /var/cache/yum/*
# 
# RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
#     echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
# 
# ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
# ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
# 
# RUN yum install -y \
#     cuda-libraries-$CUDA_PKG_VERSION \
#     cuda-cublas-9-0-9.0.176.4-1 && \
#     rm -rf /var/cache/yum/*

#COPY .condarc /root

# Disable cache (via --build-arg CACHEBUST=$(date +%s))
ARG CACHEBUST=1

RUN cd ~ \
    && git clone https://github.com/mxmpl/conda-package.git

WORKDIR "/root/conda-package"
ENTRYPOINT ["bash", "anaconda_upload.sh"]
CMD ["pykaldi"]

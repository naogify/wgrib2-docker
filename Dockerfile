# ベースイメージとして Ubuntu 22.04 を使用
FROM ubuntu:22.04

# 非対話モードでの APT 使用を設定
ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        wget \
        libnetcdf-dev \
        libpng-dev \
        libopenjp2-7-dev \
        libjpeg-dev \
        libz-dev \
        libhdf5-dev \
        gfortran \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /usr/src

# wgrib2 v3.5.0 のソースコードをダウンロード
RUN wget https://github.com/NOAA-EMC/wgrib2/archive/refs/tags/v3.5.0.tar.gz -O wgrib2-3.5.0.tar.gz

# ダウンロードしたアーカイブを解凍
RUN tar -xzf wgrib2-3.5.0.tar.gz && rm wgrib2-3.5.0.tar.gz

# 解凍したディレクトリに移動
WORKDIR /usr/src/wgrib2-3.5.0

# ビルド用ディレクトリを作成し、CMake でビルド
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make -j$(nproc) && \
    make install

# ビルドに不要なパッケージを削除してイメージサイズを縮小
RUN apt-get remove -y build-essential cmake wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/src/wgrib2-3.5.0

# /usr/local/bin を PATH に追加
ENV PATH="/usr/local/bin:${PATH}"

# デフォルトのコマンドを wgrib2 に設定
ENTRYPOINT ["wgrib2"]

# コンテナ起動時に引数がなければヘルプを表示
CMD ["-help"]

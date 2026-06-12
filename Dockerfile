FROM ghcr.io/prefix-dev/pixi:noble

WORKDIR /opt/env

COPY pixi.toml pixi.lock ./

RUN CONDA_OVERRIDE_CUDA=12 pixi install --locked

ENV PATH="/opt/env/.pixi/envs/default/bin:$PATH"

ENV PYTHONPATH="/workspace/src"

WORKDIR /workspace


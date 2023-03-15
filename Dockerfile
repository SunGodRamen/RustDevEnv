FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y curl git neovim ripgrep && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    . $HOME/.cargo/env && \
    rustup toolchain add nightly && \
    rustup component add rls rust-analysis rust-src rustfmt clippy

RUN mkdir -p /app
WORKDIR /app

COPY .config/nvim/init.lua /root/.config/nvim/init.lua
COPY .config/nvim/coc-settings.json /root/.config/nvim/coc-settings.json

CMD ["nvim"]

FROM elixir:1.14.1

ENV DEBIAN_FRONTEND=noninteractive
# Install inotify-tools
RUN apt-get update && \
    apt-get install -y inotify-tools

# Install starship
RUN curl -OfsL https://starship.rs/install.sh && \
    chmod +x install.sh && ./install.sh -y && rm install.sh
RUN echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Install Phoenix
RUN mix archive.install hex phx_new 1.6.14 --force

WORKDIR /pento
ADD . /pento

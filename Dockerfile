FROM elixir:1.14.1

ENV DEBIAN_FRONTEND=noninteractive

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Install Phoenix
RUN mix archive.install hex phx_new 1.6.14 --force

# Install inotify-tools
RUN apt-get update && \
    apt-get install -y inotify-tools

WORKDIR /pento
ADD . /pento

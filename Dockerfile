FROM debian:testing

ARG USER_NAME=latex
ARG USER_HOME=/home/latex
ARG USER_ID=1000
ARG USER_GECOS=LaTeX

RUN useradd \
  --home-dir "$USER_HOME" \
  -m \
  --uid $USER_ID \
  "$USER_NAME"

ARG WGET=wget
ARG GIT=git
ARG MAKE=make
ARG PANDOC=pandoc
ARG PYGMENTS=python3-pygments
ARG FIG2DEV=fig2dev
ARG SCIPY=python3-scipy
ARG MATPLOTLIB=python3-matplotlib

RUN apt-get update && apt-get install -y \
  texlive-full \
  # some auxiliary tools
  "$WGET" \
  "$GIT" \
  "$MAKE" \
  # markup format conversion tool
  "$PANDOC" \
  # XFig utilities
  "$FIG2DEV" \
  # syntax highlighting package
  "$PYGMENTS" \
  "$SCIPY" \
  "$MATPLOTLIB" && \
  # Removing documentation packages *after* installing them is kind of hacky,
  # but it only adds some overhead while building the image.
  apt-get --purge remove -y .\*-doc$ && \
  # Remove more unnecessary stuff
  apt-get clean -y

RUN apt-get install -y pdftk
RUN apt-get install -y tree


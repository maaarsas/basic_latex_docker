FROM blang/latex:ubuntu

MAINTAINER Martynas Šapalas

ADD ./config/fonts/Palemonas-2.1 /usr/share/fonts/truetype/Palemonas-2.1

ARG SRC_DIR="/data"
ARG XELATEX_RUN="xelatex -output-directory ${SRC_DIR}/out document.tex"
ARG BIBER_RUN="biber -output-directory ${SRC_DIR}/out ${SRC_DIR}/out/document"

RUN printf '#!/bin/bash\ncd %s \n%s \n%s \n%s' "${SRC_DIR}/config" "${XELATEX_RUN}" "${BIBER_RUN}" "${XELATEX_RUN}" >> /usr/bin/compile
RUN ["chmod", "+x", "/usr/bin/compile"]

RUN mkdir -p ${SRC_DIR}/out

RUN apt-get update
RUN apt-get install -y biber
RUN apt-get install -y fonts-texgyre

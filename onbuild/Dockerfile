FROM curiyo/meteord:base
MAINTAINER Kivun Hadash.

ONBUILD COPY ./ /app
ENV LESS_GLOBALVARS={\"less_cdnTomcat\":\"'api.curiyo.com'\"}
ONBUILD RUN bash $METEORD_DIR/on_build.sh

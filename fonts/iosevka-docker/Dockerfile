FROM ubuntu

RUN apt-get update \
&& apt-get install -y \
   build-essential \
   curl \
   ttfautohint \
   git \
   curl \
&& curl -sL https://deb.nodesource.com/setup_8.x | bash - \
&& apt-get update \
&& apt-get install -y nodejs \
&& git clone https://github.com/be5invis/Iosevka.git /src

WORKDIR /tmp
RUN curl -sLo premake5.tar.gz https://github.com/premake/premake-core/releases/download/v5.0.0-alpha11/premake-5.0.0-alpha11-linux.tar.gz \
&& tar xvf premake5.tar.gz && mv premake5 /usr/local/bin/premake5 && rm premake5.tar.gz \
&& curl -sLo otfcc.tar.gz https://github.com/caryll/otfcc/archive/v0.8.4.tar.gz \
&& tar xvf otfcc.tar.gz && mv otfcc-0.8.4 otfcc \
&& cd /tmp/otfcc \
&& premake5 gmake && cd build/gmake && make config=release_x64 \
&& cd /tmp/otfcc/bin/release-x64 \
&& mv otfccbuild /usr/local/bin/otfccbuild \
&& mv otfccdump /usr/local/bin/otfccdump \
&& rm -rf /tmp/otfcc/ /tmp/otfcc.tar.gz

WORKDIR /src
RUN npm install

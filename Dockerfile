FROM ubuntu:18.10
RUN apt-get update                                            && \
    apt-get upgrade -y                                        && \
    apt-get install -y build-essential less wget              && \
    apt-get install -y libssl-dev zlib1g-dev openssl          && \
    apt-get install -y libexpat1-dev libxml++2.6-dev          && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata  && \
    echo "DONE"

RUN echo "Install Perl" && \
    wget https://www.cpan.org/src/5.0/perl-5.28.1.tar.gz && \
    tar -xzf perl-5.28.1.tar.gz                          && \
    cd perl-5.28.1                                       && \
    ./Configure -des -Dprefix=$HOME/perl5               && \
    make                                                && \
#    make test                                           && \
    make install                                        && \
    echo "DONE"

ENV PATH="/root/perl5/bin:${PATH}"

RUN echo "Install cpanm"            && \
    wget https://cpanmin.us         && \
    perl index.html App::cpanminus  && \
    rm -f index.html                && \
    echo "DONE"


COPY cpanfile cpanfile
RUN cpanm --notest Net::SSLeay               && \
    cpanm --force Graphics::ColorNames::WWW  && \
    cpanm --force DateTime::Format::CLDR     && \
    echo "DONE"
RUN cpanm . --installdeps

WORKDIR /opt

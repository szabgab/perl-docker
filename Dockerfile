FROM ubuntu:18.10
RUN apt-get update                                  && \
    apt-get upgrade -y                              && \
    apt-get install -y build-essential less wget    && \
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
RUN cpanm . --installdeps


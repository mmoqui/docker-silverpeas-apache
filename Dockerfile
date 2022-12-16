FROM ubuntu:jammy

MAINTAINER Miguel Moquillon "miguel.moquillon@silverpeas.org"

ENV TERM=xterm

RUN apt-get update \
  && apt-get install -y tzdata \
  && apt-get install -y \
    curl \
    psmisc \
    iputils-ping \
    vim \
    procps \
    net-tools \
    zip \
    unzip \
    ca-certificates \
    apache2 \
  && rm -rf /var/lib/apt/lists/* \
  && update-ca-certificates -f \
  && mkdir -p /etc/apache2/ssl \
  && mkdir -p /usr/share/ca-certificates/home

COPY src/inputrc /root/.inputrc
COPY src/silverpeas.conf /etc/apache2/sites-available/
COPY src/ssl/silverpeas-main /etc/apache2/ssl/silverpeas-main
COPY src/ssl/silverpeas-stable /etc/apache2/ssl/silverpeas-stable
COPY src/ssl/CA/rootCA.crt /usr/share/ca-certificates/home/
COPY src/ssl/CA/rootCA.pem /usr/share/ca-certificates/home/
COPY src/run.sh /usr/local/bin/

RUN echo "home/rootCA.crt" >> /etc/ca-certificates.conf \
  && update-ca-certificates \
  && a2enmod proxy proxy_http rewrite ssl headers reqtimeout http2 \
  && a2dissite 000-default.conf default-ssl.conf \
  && a2ensite silverpeas.conf

# Default HTTP ports
EXPOSE 80 443

STOPSIGNAL SIGWINCH

# What to execute by default when running the container
CMD ["/usr/local/bin/run.sh"]

FROM r-base:latest

MAINTAINER Analytics Anonymous


RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libxt-dev \
    libssl-dev \
    gsl-bin \
    libgsl0-dev

# Download and install shiny server
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb

RUN R -e "install.packages(c('shiny', 'shinydashboard', 'dplyr','shinythemes','leaflet','htmlwidgets','htmltools','ggmap','DT','stats','tibble','ggplot2','plotly','reshape2','geojsonio','sp','leafletminicharts','Cairo','ggthemes'), repos='http://cran.rstudio.com/')"

COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

COPY . /srv/shiny-server/

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]

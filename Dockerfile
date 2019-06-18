FROM phpdockerio/php71-fpm:latest
WORKDIR "/application"

RUN apt-get update
RUN apt-get install sudo

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#USER docker

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install php7.1-mysql php-redis php7.1-gd php7.1-imap php-imagick php7.1-interbase php7.1-intl php-mongodb php7.1-soap php7.1-tidy php7.1-xmlrpc php7.1-xsl php-yaml php-xdebug php7.1-dev php-pear libv8-dev g++ cpp python-software-properties software-properties-common \
    && add-apt-repository -y ppa:pinepain/php \
    && apt-get update -y \
    && apt-get install -y php-v8 \
    && php --ri v8 \
    && apt-get -y install git \
	&& apt-get install -y curl htop man unzip vim wget telnet netcat zip \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN apt-get update \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && sudo apt-get install -y nodejs \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN apt-get update \
    && apt-get install -y build-essential ruby-full ruby-compass libpng16-16 libpng-dev pngcrush optipng pngquant libmagickwand-dev imagemagick mcrypt \
    && sudo gem install rmagick spriteful sass \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

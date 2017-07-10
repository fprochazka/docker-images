FROM php:7.0-cli

RUN apt-get update \
    && apt-get install -y \
        libpng-dev \
        libbz2-dev \
        libjpeg-dev \
        libcurl4-openssl-dev \
        libedit-dev \
        libpcre3-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        zlib1g-dev \
        libicu-dev \
        libpq-dev \
        librecode-dev \
        libgmp-dev \
        libc-client-dev \
        libkrb5-dev \
        libldb-dev libldap2-dev \
        libpspell-dev \
        libtidy-dev \
        libxslt1-dev \
    && ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
    && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so

RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install \
        bcmath \
        bz2 \
        curl \
        dom \
        exif fileinfo \
#    	filter \
        ftp \
        gd \
        gettext \
        gmp \
        hash \
        iconv \
        imap \
        intl \
        json \
        ldap \
        mbstring \
        opcache \
        pcntl \
        pdo pdo_mysql pdo_pgsql pdo_sqlite pgsql \
        phar \
        posix \
        pspell \
        readline \
#    	reflection \
        session \
#    	xmlreader xmlwriter \
        simplexml soap tidy xml xmlrpc xsl \
        sockets \
        tokenizer \
        zip

RUN yes | pecl install xdebug \
#    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN pecl install redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/ext-redis.ini

RUN rm -rf /var/lib/apt/lists/*

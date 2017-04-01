FROM php:7.0-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zsh \
        wget \
        git \
        vim \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    mbstring \
    mysqli \
    pdo_mysql

# Instal Oh my Zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN sed -i -- 's/robbyrussell/ys/g' /root/.zshrc
RUN echo "plugins=(git symfony2)" >> ~/.zshrc

COPY ./php.ini /usr/local/etc/php/php.ini

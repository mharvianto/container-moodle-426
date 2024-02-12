FROM php:8.2-apache-bullseye

#Packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    unoconv \
    unzip \
    git \
    zlib1g-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    nano \
    cron \
    && rm -rf /var/lib/apt/lists/*

#PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install curl mbstring soap zip intl exif opcache mysqli

#PHP 7.4
# RUN docker-php-ext-install xmlrpc

#PHP 8.0
RUN pecl install channel://pecl.php.net/xmlrpc-1.0.0RC3 \
    && docker-php-ext-enable xmlrpc

RUN pecl install redis && docker-php-ext-enable redis

#Moodle appfiles
# RUN git clone --single-branch -b MOODLE_402_STABLE https://github.com/moodle/moodle.git /var/www/html/
# RUN git clone --single-branch -b MOODLE_402_STABLE https://github.com/moodle/moodle.git /var/www/html/
# RUN curl -LO https://packaging.moodle.org/stable402/moodle-4.2.2.tgz \
#     && tar -xzf moodle-4.2.2.tgz -C /var/www/html/ --strip-components=1 \
#     && rm moodle-4.2.2.tgz

#https://moodle.org/plugins/download.php/28958/mod_attendance_moodle42_2023041800.zip


#Config files
COPY additional-php-setting.ini /usr/local/etc/php/conf.d/additional-php-setting.ini
#!/bin/bash 

# assuming Git-repo has been unpacked in /tmp
cd /tmp

# add APK-repositories configuration file
# --> make sure to include a community one
mv kb-alp/etc/apk/repositories /etc/apk/repositories

# install packages, remove cache (command as in Dockerfile)
apk update && \
    apk add openssl unzip nginx bash ca-certificates s6 curl ssmtp mailx php7 php7-phar php7-curl \
    php7-fpm php7-json php7-zlib php7-xml php7-dom php7-ctype php7-opcache php7-zip php7-iconv \
    php7-pdo php7-pdo_mysql php7-pdo_sqlite php7-pdo_pgsql php7-mbstring php7-session php7-bcmath \
    php7-gd php7-mcrypt php7-openssl php7-sockets php7-posix php7-ldap php7-simplexml && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/www/localhost && \
    rm -f /etc/php7/php-fpm.d/www.conf

# get kanboard repo, move files to application folder (command as in Dockerfile, with fixed version)
curl -sL -o kb.zip https://github.com/kanboard/kanboard/archive/v1.2.7.zip \
    && unzip -qq kb.zip \
    && cd kanboard-* \
    && cp -R . /var/www/app \
    && cd /tmp \
    && rm -rf /tmp/kanboard-* /tmp/*.zip

# make directories (volumes in Dockerfile)
mkdir /var/www/app/data
mkdir /var/www/app/plugins
mkdir /etc/nginx/ssl

# copy configuration files (similar to the "ADD docker/ /" command)
# TODO

# create symlink to entrypoint
# cd /root
# ln -s start.sh /usr/local/bin/entrypoint.sh
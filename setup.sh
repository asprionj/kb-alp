#!/bin/bash

# assuming git-repo has been unpacked in /tmp
cd /tmp

# add APK-repositories configuration file after backing up default one
# --> make sure to include a community one
mv /etc/apk/repositories /etc/apk/repositories.BAK
mv asprionj-kb-alp-*/etc/apk/repositories /etc/apk/repositories

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

# make SSL directory for nginx
mkdir /etc/nginx/ssl

# copy configuration files (similar to the "ADD docker/ /" command)
mv asprionj-kb-alp-*/etc/crontabs/nginx /etc/crontabs/

mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.BAK
mv asprionj-kb-alp-*/etc/nginx/nginx.conf /etc/nginx/

mv /etc/php7/php-fpm.conf /etc/php7/php-fpm.conf.BAK
mv asprionj-kb-alp-*/etc/php7/php-fpm.conf /etc/php7/
mv asprionj-kb-alp-*/etc/php7/conf.d/local.ini /etc/php7/conf.d/
mv asprionj-kb-alp-*/etc/php7/php-fpm.d/env.conf /etc/php7/php-fpm.d/

mv asprionj-kb-alp-*/etc/services.d /etc/

mv asprionj-kb-alp-*/usr/local/bin/entrypoint.sh /usr/local/bin/

mv asprionj-kb-alp-*/var/www/app/config.php /var/www/app/

# remove unpacked git-repo
rm -r asprionj-kb-alp-*

# make stuff executable (why aren't they already?!?)
chmod ugo+x /etc/services.d/.s6-svscan/finish
chmod ugo+x /etc/services.d/cron/run
chmod ugo+x /etc/services.d/nginx/run
chmod ugo+x /etc/services.d/php/run

# create symlink to entrypoint in /root
cd /root
ln -s /usr/local/bin/entrypoint.sh start.sh






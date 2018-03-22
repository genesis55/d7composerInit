FROM cbiit/centos7:base
MAINTAINER Shaun Einolf
#March 22, 2018 - Added Composer

LABEL \
  BASE_OS="CBIIT CentOS 7" \
  DEFAULT_IMAGE="cbiit/centos7" \
  DEFAULT_TAG="centos7" \
  DESCRIPTION="Deployment environment for drupal (based on CentOS 7)" \
  VERSION="1.0" \
  UID="DRUPAL_1.0_C7"

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
  && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

RUN yum install -y yum-plugin-ovl
RUN yum -y update
RUN yum -y install \
    drush \
    git \
    httpd \
    initscripts \
    mariadb \
    php70w \
    php70w-cli \
    php70w-fpm \
    php70w-gd \
    php70w-mbstring \
    php70w-mcrypt \
    php70w-mysqlnd \
    php70w-opcache \
    php70w-xml \
    procnps \
    supervisor \
    util-linux \
    vi \
    which \
    curl

RUN cd tmp \
  && drush dl drupal-7.52

#install composer
RUN cd tmp \
  && curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer 

ADD conf/.htaccess /tmp

COPY conf/php.ini /etc/  

# copy supervisord conf #
ADD conf/supervisord.conf /etc/supervisord.conf
ADD conf/supervisord.conf /etc/supervisor/supervisord.conf
ADD conf/httpd.conf /etc/httpd/conf/httpd.conf

ADD run.sh /usr/bin/
RUN chmod 777 /usr/bin/run.sh

# expose httpd port #
EXPOSE 80


# start supervisor #
ENTRYPOINT ["/usr/bin/run.sh"]

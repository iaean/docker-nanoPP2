FROM php:7.2-alpine

MAINTAINER Andreas Schulze <asl@iaean.net>

ENV nanoPP2_BASE=/var/www/html
ENV nanoPP2_MEDIA=content
ENV nanoPP2_VERSION=1.1.0

RUN apk add --no-cache sudo bash && \
    apk add --no-cache php7-gd && \
    echo "extension=/usr/lib/php7/modules/gd.so" > /usr/local/etc/php/conf.d/gd.ini && \
    echo "max_execution_time = 0" > /usr/local/etc/php/conf.d/nanoPP2.ini && \
    mkdir -p ${nanoPP2_BASE}/${nanoPP2_MEDIA} && \
    wget https://github.com/nanostudio-org/nano_photos_provider2/archive/v${nanoPP2_VERSION}.zip && \
    unzip v${nanoPP2_VERSION}.zip && \
    cp -r nano_photos_provider2-${nanoPP2_VERSION}/dist/*.* ${nanoPP2_BASE} && \
    rm -rf nano_photos_provider2-${nanoPP2_VERSION} v${nanoPP2_VERSION}.zip

COPY docker-entrypoint.sh /entrypoint.sh

WORKDIR ${nanoPP2_BASE}
VOLUME ${nanoPP2_BASE}/${nanoPP2_MEDIA}

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/local/bin/php", "-S", "0.0.0.0:80"]

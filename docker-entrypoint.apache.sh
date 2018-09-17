#!/bin/bash
set -e

# return true if specified directory is empty
function directory_empty() {
  [ -n "$(find "${1}"/ -prune -empty)" ]
}

echo Running: "$@"

cat <<EOT >${nanoPP2_BASE}/nano_photos_provider2.cfg
[config]
fileExtensions="${fileExtensions:-jpg|jpeg|png|gif}"
contentFolder="${nanoPP2_MEDIA:-nano_photos_content}"
sortOrder="${sortOrder:-asc}"
titleDescSeparator="${titleDescSeparator:-\$\$}"
albumCoverDetector="${albumCoverDetector:-@@@@@}"
ignoreDetector="${ignoreDetector:-_hidden}"

[images]
maxSize=${maxSize:-1900}
jpegQuality=${jpegQuality:-85}

[thumbnails]
jpegQuality=${jpegThumbsQuality:-85}
blurredImageQuality=${blurredImageQuality:-3}
allowedSizeValues="${allowedSizeValues:-}"

[security]
allowOrigins="${allowOrigins:-*}"

[memory]
unlimited=${unlimited:-false}
EOT

sed -i -e "s/^Timeout .*/Timeout ${nanoPP2_TIMEOUT}/g" /etc/apache2/conf.d/default.conf
sed -i -e "s/^max_execution_time.*/max_execution_time = ${nanoPP2_TIMEOUT}/g" /etc/php7/php.ini
# sed -i -e "s/^max_input_time.*/max_input_time = ${nanoPP2_TIMEOUT}/g" /etc/php7/php.ini
if [[ -n ${nanoPP2_MEMORY} ]]; then
  sed -i -e "s/^memory_limit.*/memory_limit = ${nanoPP2_MEMORY}/g" /etc/php7/php.ini
fi

###
### Start apache...
###

if [[ `basename ${1}` == "httpd" ]]; then # prod
  # The tail approach...
  #
  # touch /var/log/apache2/error.log
  # touch /var/log/apache2/subversion.log
  # touch /var/log/apache2/access.log
  #
  # tail -f /var/log/apache2/error.log &
  # tail -f /var/log/apache2/subversion.log &
  # tail -f /var/log/apache2/access.log &

  # The direct approach...
  #
  ln -sf /dev/stderr /var/log/apache2/error.log
  ln -sf /dev/stdout /var/log/apache2/access.log
  ln -sf /dev/stdout /var/log/apache2/subversion.log

  exec "$@" </dev/null #>/dev/null 2>&1
else # dev
  rm -f /var/log/apache2/error.log
  rm -f /var/log/apache2/access.log
  rm -f /var/log/apache2/subversion.log

  httpd -k start
fi

# fallthrough...
exec "$@"

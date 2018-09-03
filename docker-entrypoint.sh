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

###
### Start web server...
###

if [[ `basename ${1}` == "php" ]]; then # prod
  exec "$@" </dev/null #>/dev/null 2>&1
else # dev
  /usr/local/bin/php -S 0.0.0.0:80
fi

# fallthrough...
exec "$@"

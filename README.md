# docker-nanoPP2
Docker container for [nanoPhotosProvider2][2].

[1]: https://nanophotosprovider2.nanostudio.org/
[2]: https://github.com/nanostudio-org/nano_photos_provider2/

## Features
* Ultra small [Alpine Linux][3] based image
* Complete autoconfiguration via environment

[3]: https://alpinelinux.org/

## Installation
* Get it from [docker hub][4]: `docker pull iaean/nanopp2`
* -or- build the image as you normally would: `docker build --tag=nanopp2 ./`
* Setting your environment...
* ...Yee-haw!

[4]: https://hub.docker.com/r/iaean/nanopp2/

## Autoconfiguration via environment

Supported options are:

`nanoPP2_TIMEOUT`, `ENVIRONMENT`, `fileExtensions`, `sortOrder`, 
`titleDescSeparator`, `albumCoverDetector`, `ignoreDetector`, 
`maxSize`, `jpegQuality`, `jpegThumbsQuality`, `blurredImageQuality`,
`allowedSizeValues`, `allowOrigins`, `unlimited`

For explanation see [nanoPhotosProvider2][1].

Docker `--env-file` example:

```ini
# ENVIRONMENT=development
# nanoPP2_TIMEOUT=90

albumCoverDetector=@@@
maxSize=3072
jpegQuality=95
jpegThumbsQuality=100
blurredImageQuality=5

# allowedSizeValues=50|100|225|150|200|300|auto
# allowOrigins=http://nanogallery2.nanostudio.org|https://nanogallery2.nanostudio.org
```

## Running
To provide adequate security and handle your certificate bale, you are highly encouraged to run the `http://` part behind a SSL enabled reverse proxy and publishing `https://` only.

```apache
# All your SSL and virtual host stuff...

<Location />
  SSLRequireSSL
</Location>

ProxyPreserveHost On
RequestHeader set X-Forwarded-Proto "https"

ProxyPass / http://nanopp2:4711/
ProxyPassReverse / http://nanopp2:4711/
```

### Running the docker image
Use docker to run the container as you normally would.

Production:

`docker run -p 80:80 --env-file env --rm --name nanopp2 nanopp2`

Devolopment:

`docker run -it -p 80:80 --env-file env --rm --name nanopp2 nanopp2 /bin/sh`

`docker exec -it nanopp2 /bin/sh`

### Attach to [nanogallery2][5]

```javascript
$("#nanogallery2").nanogallery2({
  // ...
  kind:             "nano_photos_provider2",
  dataProvider:     "//nanopp2/nano_photos_provider2.php",
  locationHash:     false
});
```

[5]: https://nanogallery2.nanostudio.org/

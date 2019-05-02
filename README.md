# docker-errbot

## Build image
```
docker build ./ -t errbot:alpine
```

## Errbot start
```
docker run --rm -it --name errbot errbot:alpine
```

## Errbot start with local config file
```
docker run --rm -it --name errbot -v $(pwd)/plugins:/app/plugins:ro -p 5678:5678 -e DEBUG=true errbot:alpine debug
```

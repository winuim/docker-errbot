# docker-errbot

## Build image
```
docker build ./ -t winuim/errbot
```

## Errbot start
```
docker run --rm -it --name errbot winuim/errbot
```

## Debugging a errtbot plugin.
```
docker run --rm -it --name errbot -v $(pwd)/plugins:/app/plugins:ro -p 5678:5678 -e DEBUG=true winuim/errbot debug
```

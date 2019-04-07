# docker-errbot

## Build image
```
docker build ./ -t errbot
```

## Errbot start
```
docker run --rm -it errbot
```

## Errbot start with local config file
```
docker run --rm -it -v $(pwd)/srv:/app/srv -p 5678:5678 errbot
```

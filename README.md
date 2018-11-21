# docker-errbot

## Build image
```
docker build ./ -t errbot
docker image prune
```

## Errbot start. Backend Text mode
```
docker run --rm -it errbot
```

## Bash start. and errbot start.
```
docker run --rm -it errbot bash
sh run.sh
```

## Develop mode errbot start.
```
docker run --rm -it -v $(pwd)/srv:/app/srv -p 5678:5678 errbot bash
sh run.sh -d
```

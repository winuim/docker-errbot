#!/bin/bash -eu

[[ -v DEBUG ]] && ${DEBUG} && set -x

case ${1} in
    run)
        errbot -c srv/config.py
        ;;
    debug)
        python -m ptvsd --host localhost --port 5678 --wait /usr/local/bin/errbot -c srv/config.py
        ;;
    *)
        exec "$@"
        ;;
esac

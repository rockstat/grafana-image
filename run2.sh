#!/bin/bash -e

for f in $(ls -A $GF_PATHS_HOME/plugins); do mv -i "$f" $GF_PATHS_PLUGINS ; done
chown -R grafana:grafana $GF_PATHS_PLUGINS

exec ./run.sh

#!/bin/bash -e

echo "$GF_PATHS_HOME/plugins"
ls -l $GF_PATHS_HOME/plugins
echo "$GF_PATHS_PLUGINS"
find $GF_PATHS_PLUGINS

# for f in $(ls -A $GF_PATHS_HOME/plugins); do mv "$GF_PATHS_HOME/plugins/$f" $GF_PATHS_PLUGINS ; done
chown -R grafana:grafana $GF_PATHS_PLUGINS
chown -R grafana:grafana $GF_PATHS_HOME

echo "List plugins"




exec ./run.sh

#!/bin/bash -e

echo "{_TEMP_STORE}/plugins: ${_TEMP_STORE}/plugins"
echo $(ls -la ${_TEMP_STORE}/plugins)
echo "{_PLUGINS}: ${_PLUGINS}"
ls -la $_PLUGINS

if [ ! -d "$GF_PATHS_PLUGINS" ]; then
    mkdir "$GF_PATHS_PLUGINS"
fi

echo "{_PLUGINS}/2: ${_PLUGINS}"
ls -la $_PLUGINS

# for f in $(ls -A ${_TEMP_STORE}/plugins); do echo "${_TEMP_STORE}/plugins -> ${_PLUGINS}/$f" && mv -u "${_PLUGINS}/$f" $_PLUGINS ; done


exec ./run.sh

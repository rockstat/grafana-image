#!/bin/bash -e

echo "-> {_TEMP_STORE}/plugins: ${_TEMP_STORE}/plugins"
echo "->$(ls -la ${_TEMP_STORE}/plugins)"
echo "->{_PLUGINS}: ${_PLUGINS}"
ls -la $_PLUGINS

if [ ! -d "$GF_PATHS_PLUGINS" ]; then
    mkdir "$GF_PATHS_PLUGINS"
fi
if [ ! -d "${_DATA}/dashboards" ]; then
    mkdir "${_DATA}/dashboards"
fi

echo "-> {_PLUGINS}/2: ${_PLUGINS}"
ls -la $_PLUGINS

if [ ! -d "${_DATA}/dash" ]; then
    mv "${_TEMP_STORE}/dash/dashboard.json" "${_DATA}/dashboards"
fi

for f in $(ls -A ${_TEMP_STORE}/plugins); do
    echo "-> ${_TEMP_STORE}/plugins -> ${_PLUGINS}/$f"
    if [ ! -d "${_PLUGINS}/$f" ]; then
        echo "-> mv"
        mv -u -f "${_TEMP_STORE}/plugins/$f" ${_PLUGINS}
    fi
done


exec ./run.sh

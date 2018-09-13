#!/bin/bash -e

ls -l /usr/share/grafana_build

mkdir -p "$RST_PROV_DIR/plugins"
cd "$RST_PROV_DIR/plugins" && mv * "$GF_PATHS_PLUGINS/" && cd -

# mv -t $GF_PATHS_PLUGINS $RST_PROV_DIR/plugins/*
mv "$RST_PROV_DIR/grafana.ini" "$GF_PATHS_DATA/"


if [ ! -z "${GF_INSTALL_PLUGINS}" ]; then \
    OLDIFS=$IFS; \
        IFS=','; \
    for plugin in ${GF_INSTALL_PLUGINS}; do \
        IFS=$OLDIFS; \
        grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install ${plugin}; \
    done; \
fi


exec ./run.sh

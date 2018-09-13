#!/bin/bash -e

mv "$RST_PROV_DIR/plugins/*" "$GF_PATHS_PLUGINS/"
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

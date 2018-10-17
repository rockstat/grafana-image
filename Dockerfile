# https://github.com/grafana/grafana/blob/master/Dockerfile

ARG GRAFANA_VERSION="latest"

FROM grafana/grafana:${GRAFANA_VERSION}

USER grafana

COPY provisioning/dashboards/all.yml \
    provisioning/dashboards/dashboard.json \
    $GF_PATHS_PROVISIONING/dashboards/
COPY provisioning/datasources/all.yml \
    $GF_PATHS_PROVISIONING/datasources
COPY grafana.ini $GF_PATHS_CONFIG

ARG RS_GF_INSTALL_PLUGINS="vertamedia-clickhouse-datasource,grafana-clock-panel,grafana-simple-json-datasource,grafana-piechart-panel,jdbranham-diagram-panel,raintank-worldping-app,ryantxu-ajax-panel,natel-discrete-panel"

RUN if [ ! -z "${RS_GF_INSTALL_PLUGINS}" ]; then \
        OLDIFS=$IFS; \
            IFS=','; \
        for plugin in ${RS_GF_INSTALL_PLUGINS}; do \
            IFS=$OLDIFS; \
            grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install ${plugin}; \
        done; \
    fi

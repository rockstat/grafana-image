# https://github.com/grafana/grafana/blob/master/Dockerfile

FROM grafana/grafana:latest

ENV GF_PATHS_PLUGINS=$GF_PATHS_HOME/plugins

USER root

RUN mkdir -p $GF_PATHS_PLUGINS \
    && chown grafana:grafana $GF_PATHS_PLUGINS \
    && chmod 0777 $GF_PATHS_PLUGINS

USER grafana

COPY provisioning/dashboards/all.yml \
    provisioning/dashboards/dashboard.json \
    $GF_PATHS_PROVISIONING/dashboards/
COPY provisioning/datasources/all.yml \
    $GF_PATHS_PROVISIONING/datasources
COPY grafana.ini $GF_PATHS_CONFIG

# vertamedia-clickhouse-datasource
ARG RS_GF_INSTALL_PLUGINS="grafana-clock-panel,grafana-simple-json-datasource,grafana-piechart-panel,jdbranham-diagram-panel,raintank-worldping-app,ryantxu-ajax-panel,natel-discrete-panel"

RUN set -e && if [ ! -z "${RS_GF_INSTALL_PLUGINS}" ]; then \
        OLDIFS=$IFS; \
            IFS=','; \
        for plugin in ${RS_GF_INSTALL_PLUGINS}; do \
            IFS=$OLDIFS; \
            grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install ${plugin}; \
        done; \
    fi
RUN grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" --pluginUrl https://149208.selcdn.ru/dg/clickhouse-grafana.zip plugins install vertamedia-clickhouse-datasource

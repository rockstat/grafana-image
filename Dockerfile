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


ENV ALT_GF_INSTALL_PLUGINS="vertamedia-clickhouse-datasource,grafana-clock-panel,grafana-simple-json-datasource,grafana-piechart-panel,jdbranham-diagram-panel,raintank-worldping-app,ryantxu-ajax-panel,natel-discrete-panel"

COPY ./setup_plugins.sh ./
RUN ./setup_plugins.sh

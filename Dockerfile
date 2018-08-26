FROM grafana/grafana

RUN grafana-cli plugins install grafana-clock-panel \
    && grafana-cli plugins install grafana-simple-json-datasource \
    && RUN grafana-cli plugins install vertamedia-clickhouse-datasource \
    && RUN grafana-cli plugins install grafana-piechart-panel \
    && RUN grafana-cli plugins install petrslavotinek-carpetplot-panel \
    && RUN grafana-cli plugins install jdbranham-diagram-panel \
    && RUN grafana-cli plugins install raintank-worldping-app \
    && RUN grafana-cli plugins install ryantxu-ajax-panel \
    && RUN grafana-cli plugins install natel-discrete-panel


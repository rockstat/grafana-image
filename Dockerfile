FROM grafana/grafana

RUN grafana-cli plugins install grafana-clock-panel \
    && grafana-cli plugins install grafana-simple-json-datasource \
    && grafana-cli plugins install vertamedia-clickhouse-datasource \
    && grafana-cli plugins install grafana-piechart-panel \
    && grafana-cli plugins install jdbranham-diagram-panel \
    && grafana-cli plugins install raintank-worldping-app \
    && grafana-cli plugins install ryantxu-ajax-panel \
    && grafana-cli plugins install natel-discrete-panel \
    && grafana-cli plugins install petrslavotinek-carpetplot-panel
COPY grafana.ini /etc/grafana/

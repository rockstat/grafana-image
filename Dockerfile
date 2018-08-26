FROM grafana/grafana

RUN grafana-cli plugins install grafana-clock-panel

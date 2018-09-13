FROM grafana/grafana

USER root
ENV RST_PROV_DIR=/root/provisioning
RUN mkdir -p "$RST_PROV_DIR"

COPY grafana.ini /etc/grafana/
COPY datasource.yml /etc/grafana/provisioning/datasources/datasource.yml
COPY dashboards.yml /etc/grafana/provisioning/dashboards/dashboards.yml
COPY dashboards /var/lib/grafana

RUN grafana-cli plugins install grafana-clock-panel \
    && grafana-cli plugins install grafana-simple-json-datasource \
    && grafana-cli plugins install vertamedia-clickhouse-datasource \
    && grafana-cli plugins install grafana-piechart-panel \
    && grafana-cli plugins install jdbranham-diagram-panel \
    && grafana-cli plugins install raintank-worldping-app \
    && grafana-cli plugins install ryantxu-ajax-panel \
    && grafana-cli plugins install natel-discrete-panel
    # && grafana-cli plugins install petrslavotinek-carpetplot-panel << not accessible

RUN mv "$GF_PATHS_PLUGINS" "$RST_PROV_DIR"
RUN chown -R grafana:grafana "$GF_PATHS_DATA"


USER grafana

COPY ./run2.sh /run2.sh
ENTRYPOINT [ "/run2.sh" ]

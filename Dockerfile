FROM grafana/grafana

USER root
ENV RST_PROV_DIR=/usr/share/grafana_build
RUN mkdir -p $RST_PROV_DIR/dashboards

COPY --chown=grafana:grafana provisioning grafana.ini /etc/grafana/
COPY --chown=grafana:grafana dashboards $RST_PROV_DIR/dashboards/

RUN grafana-cli plugins install grafana-clock-panel \
    && grafana-cli plugins install grafana-simple-json-datasource
    # && grafana-cli plugins install vertamedia-clickhouse-datasource \
    # && grafana-cli plugins install grafana-piechart-panel \
    # && grafana-cli plugins install jdbranham-diagram-panel \
    # && grafana-cli plugins install raintank-worldping-app \
    # && grafana-cli plugins install ryantxu-ajax-panel \
    # && grafana-cli plugins install natel-discrete-panel
    # && grafana-cli plugins install petrslavotinek-carpetplot-panel << not accessible

RUN mv "$GF_PATHS_PLUGINS" "$RST_PROV_DIR"
RUN find "$RST_PROV_DIR"
RUN chown -R grafana:grafana "$RST_PROV_DIR"

COPY ./run2.sh /run2.sh

USER grafana
ENTRYPOINT [ "/run2.sh" ]

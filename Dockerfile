FROM grafana/grafana

RUN mkdir $GF_PATHS_DATA/dashboards/
COPY --chown=grafana:grafana provisioning grafana.ini /etc/grafana/
COPY --chown=grafana:grafana dashboards $GF_PATHS_DATA/dashboards/

RUN grafana-cli plugins install grafana-clock-panel \
    && grafana-cli plugins install grafana-simple-json-datasource \
    && grafana-cli plugins install vertamedia-clickhouse-datasource \
    && grafana-cli plugins install grafana-piechart-panel \
    && grafana-cli plugins install jdbranham-diagram-panel \
    && grafana-cli plugins install raintank-worldping-app \
    && grafana-cli plugins install ryantxu-ajax-panel \
    && grafana-cli plugins install natel-discrete-panel
    # && grafana-cli plugins install petrslavotinek-carpetplot-panel << not accessible


USER root
VOLUME /var/lib/grafana/plugins
RUN mkdir $GF_PATHS_HOME/plugins
RUN bash -c 'for f in $(ls -A $GF_PATHS_PLUGINS); do mv -f "$GF_PATHS_PLUGINS/$f" $GF_PATHS_HOME/plugins && echo "moving $GF_PATHS_PLUGINS/$f -> $GF_PATHS_HOME/plugins" ; done'
RUN chown -R grafana:grafana $GF_PATHS_HOME
RUN ls $GF_PATHS_HOME/plugins

COPY run2.sh run2.sh

USER grafana
ENTRYPOINT [ "/run2.sh" ]

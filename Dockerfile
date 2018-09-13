FROM grafana/grafana


ENV GF_PATHS_PLUGINS=/usr/share/grafana/plugins

ENV _TEMP_STORE=$GF_PATHS_HOME/_data
ENV _PLUGINS=$GF_PATHS_PLUGINS
ENV _DATA=$GF_PATHS_DATA
ENV _DASH_SRC=${_TEMP_STORE}/dashboards/dashboard.json
ENV _DASH_DST=${_DATA}/dashboards/dashboard.json

USER root

RUN mkdir -p $GF_PATHS_PLUGINS && chown -R grafana:grafana $GF_PATHS_PLUGINS && chmod -R 777 $GF_PATHS_PLUGINS
# RUN apt update -yqq && apt install -yqq gosu

COPY provisioning/dashboards/all.yml $GF_PATHS_PROVISIONING/dashboards
COPY provisioning/dashboards/dashboard.json $GF_PATHS_PROVISIONING/dashboards
COPY provisioning/datasources/all.yml $GF_PATHS_PROVISIONING/datasources
COPY grafana.ini /etc/grafana/




# RUN grafana-cli plugins install grafana-clock-panel \
#     && grafana-cli plugins install grafana-simple-json-datasource \
#     && grafana-cli plugins install vertamedia-clickhouse-datasource \
#     && grafana-cli plugins install grafana-piechart-panel \
#     && grafana-cli plugins install jdbranham-diagram-panel \
#     && grafana-cli plugins install raintank-worldping-app \
#     && grafana-cli plugins install ryantxu-ajax-panel \
#     && grafana-cli plugins install natel-discrete-panel
    # && grafana-cli plugins install petrslavotinek-carpetplot-panel << not accessible
ENV GF_INSTALL_PLUGINS="vertamedia-clickhouse-datasource,grafana-clock-panel,grafana-simple-json-datasource,grafana-piechart-panel,jdbranham-diagram-panel,raintank-worldping-app,ryantxu-ajax-panel,natel-discrete-panel"
# --chown=grafana:grafana 
COPY ./plugins.sh ./plugins.sh
RUN ./plugins.sh


RUN echo "_TEMP_STORE:${_TEMP_STORE}"
# RUN chown -R grafana:grafana $_PLUGINS
# RUN chown -R grafana:grafana ${_TEMP_STORE}/plugins
# RUN bash -c 'for f in $(ls -A $_PLUGINS); do mv -f "$_PLUGINS/$f" ${_TEMP_STORE}/plugins && echo "moving $_PLUGINS/$f -> ${_TEMP_STORE}/plugins" ; done'
# RUN chown -R grafana:grafana ${_DATA}/plugins

COPY run2.sh run2.sh
ENV GF_INSTALL_PLUGINS=""


USER grafana
ENTRYPOINT [ "/run2.sh" ]


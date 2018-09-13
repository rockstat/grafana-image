FROM grafana/grafana

ENV _TEMP_STORE=$GF_PATHS_HOME/_data
ENV _PLUGINS=$GF_PATHS_PLUGINS
ENV _DATA=$GF_PATHS_DATA

USER root
RUN apt update -yqq && apt install -yqq gosu


RUN mkdir -p ${_TEMP_STORE}/dashboards/ && mkdir -p ${_TEMP_STORE}/plugins/

COPY --chown=grafana:grafana provisioning grafana.ini /etc/grafana/
COPY --chown=grafana:grafana dashboard.json ${_TEMP_STORE}/dashboards/

RUN grafana-cli plugins install grafana-clock-panel \
    && grafana-cli plugins install grafana-simple-json-datasource \
    && grafana-cli plugins install vertamedia-clickhouse-datasource \
    && grafana-cli plugins install grafana-piechart-panel \
    && grafana-cli plugins install jdbranham-diagram-panel \
    && grafana-cli plugins install raintank-worldping-app \
    && grafana-cli plugins install ryantxu-ajax-panel \
    && grafana-cli plugins install natel-discrete-panel
    # && grafana-cli plugins install petrslavotinek-carpetplot-panel << not accessible


RUN echo "_TEMP_STORE:${_TEMP_STORE}"
# RUN chown -R grafana:grafana $_PLUGINS
# RUN chown -R grafana:grafana ${_TEMP_STORE}/plugins
RUN bash -c 'for f in $(ls -A $_PLUGINS); do mv -f "$_PLUGINS/$f" ${_TEMP_STORE}/plugins && echo "moving $_PLUGINS/$f -> ${_TEMP_STORE}/plugins" ; done'
# RUN chown -R grafana:grafana ${_DATA}/plugins
RUN echo "Plugins in ${_TEMP_STORE}/plugins" && ls ${_TEMP_STORE}/plugins

RUN chown -R grafana:grafana ${_TEMP_STORE} ${_PLUGINS} ${_DATA}

ARG hz=1
COPY run2.sh run2.sh

USER grafana
ENTRYPOINT [ "/run2.sh" ]

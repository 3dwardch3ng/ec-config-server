FROM bitnami/java:17.0.12-10-debian-12-r4

COPY ec-config-server/target/*.jar /app/app.jar

COPY ec-config-server/script/entrypoint.sh /opt/scripts/entrypoint.sh
RUN chmod 0740 /opt/scripts/entrypoint.sh

CMD /opt/scripts/entrypoint.sh
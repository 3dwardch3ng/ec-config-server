FROM bitnami/java:17.0.12-10-debian-12-r6 AS builder

WORKDIR /opt

RUN apt update && apt upgrade -y

FROM builder AS app

WORKDIR /app

RUN addgroup --gid 1001 app && adduser --uid 1001 --gid 1001 --home /app app
RUN apt clean && chown app /app

COPY --chown=1001 --from=builder /opt /opt

USER 1001

COPY --chown=1001 target/*.jar /app/app.jar

COPY --chown=1001 script/entrypoint.sh /opt/scripts/entrypoint.sh
RUN chmod 0740 /opt/scripts/entrypoint.sh

CMD /opt/scripts/entrypoint.sh

EXPOSE 8100
FROM bitnami/java:17.0.12-10-debian-12-r4 AS builder

WORKDIR /opt

RUN apt update && apt upgrade -y

FROM builder AS app

WORKDIR /app

RUN adduser --system --group --uid 1001 --home /app --no-create-home --quiet --shell /bin/bash app
RUN chown app /app

COPY --chown=1001 --from=builder /opt /opt

USER 1001

COPY --chown=1001 target/*.jar /app/app.jar

COPY --chown=1001 script/entrypoint.sh /opt/scripts/entrypoint.sh
RUN chmod 0740 /opt/scripts/entrypoint.sh

CMD /opt/scripts/entrypoint.sh
FROM        alpine:3.8 as builder

ARG         VERSION=10.22.0.6667-1

RUN         apk add --no-cache --virtual .build-deps \
                curl ca-certificates && \
            curl -sL -o - https://cloud.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-$VERSION.linux_x86_64.tar.gz | tar xz && \
            mkdir -p /etc/mongodb-mms-automation-agent && \
            mv mongodb-mms-automation-agent-$VERSION.linux_x86_64/mongodb-mms-automation-agent /usr/local/bin/mongodb-mms-automation-agent && \
            mv mongodb-mms-automation-agent-$VERSION.linux_x86_64/local.config /etc/mongodb-mms-automation-agent/local.config && \
            chmod +x /usr/local/bin/mongodb-mms-automation-agent && \
            sed -i 's/mmsGroupId=/mmsGroupId={{ default .Env.MMS_GROUP_ID "" }}/' /etc/mongodb-mms-automation-agent/local.config && \
            sed -i 's/mmsApiKey=/mmsApiKey={{ default .Env.MMS_API_KEY "" }}/' /etc/mongodb-mms-automation-agent/local.config

###

FROM        alpine:3.8 as dockerize

ARG         DOCKERIZE_VERSION=v0.6.1

RUN         wget -q https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
            tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
            rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

###

FROM        debian:10-slim

COPY        --from=dockerize /usr/local/bin/dockerize /usr/local/bin/dockerize

RUN         apt-get update && \
            apt-get install -y libsasl2-2 ca-certificates libgssapi-krb5-2 procps && \
            rm -rf /var/lib/apt/lists/*

COPY        --from=builder /usr/local/bin/mongodb-mms-automation-agent /usr/local/bin/
COPY        --from=builder /etc/mongodb-mms-automation-agent/local.config /etc/mongodb-mms-automation-agent/local.config
COPY        entrypoint.sh /entrypoint.sh

ENTRYPOINT  ["/entrypoint.sh"]

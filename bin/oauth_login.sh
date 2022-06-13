#!/bin/bash

if [ "$1" == "" ] || [ "$1" == "--help" ]; then
  echo "Usage: $0 [USER]"
  exit 1
fi

export REFRESH_TOKEN=$(/opt/kafka/bin/oauth.sh -q $1)

cat > ~/$1.properties << EOF
security.protocol=SASL_SSL
sasl.mechanism=OAUTHBEARER
sasl.jaas.config=org.apache.kafka.common.security.oauthbearer.OAuthBearerLoginModule required \
  oauth.refresh.token="$REFRESH_TOKEN" \
  oauth.client.id="$CLIENT_ID" \
  oauth.token.endpoint.uri="$TOKEN_ENDPOINT" ;
sasl.login.callback.handler.class=io.strimzi.kafka.oauth.client.JaasClientOauthLoginCallbackHandler
EOF

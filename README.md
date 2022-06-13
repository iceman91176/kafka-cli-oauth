# KAFKA-CLI with Strimzi-Oauth Support

Kafka-Cli container-image based on quay.io/strimzi/kafka that contains a helper-script to obtain a oauth-token

## Build

Build for local use
```
STRIMZI_RELEASE=0.27.1-kafka-3.0.0 make docker_build
```

or push to a registry

```
STRIMZI_RELEASE=0.27.1-kafka-3.0.0 DOCKER_REGISTRY=pub-registry.dev.witcom.services make docker_build docker_push
```

STRIMZI_RELEASE has to be a valid tag from quay.io/strimzi/kafka

## Prepare Keycloak

* Create a CLI-Client, Access-Type public, Direct-Access-Grants enabled
* Give permissions to users

## Use
```
docker run --rm -ti strimzi/kafka-cli-oauth:latest /bin/bash
```

Set the following ENV-Variables

```
export TOKEN_ENDPOINT="https://xxx/auth/realms/witcom/protocol/openid-connect/token"
export OAUTH_TOKEN_ENDPOINT_URI=$TOKEN_ENDPOINT
export CLIENT_ID=KEYCLOAK-CLIENT-ID
```

Run login script

```
./bin/oauth_login.sh username
```

Script will prompt for password to get a refresh-token from Keycloak. Token will be stored in ~/USERNAME.properties

Use kafka-tools, e.g.

```
 ./bin/kafka-consumer-groups.sh --command-config ~/my-user-name.properties --bootstrap-server bootstrap-server:9094 --list
```




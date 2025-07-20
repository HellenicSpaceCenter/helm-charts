# vim: set syntax=dockerfile:
FROM maven:3.9.6-eclipse-temurin-17 as maven-build

ARG keycloak_gsis_providers_version=v3.1.0

WORKDIR /code
ADD https://github.com/cti-nts/keycloak-gsis-providers/archive/refs/tags/${keycloak_gsis_providers_version}.tar.gz .
ADD keycloak-gsis-providers.diff .
RUN tar xzf ${keycloak_gsis_providers_version}.tar.gz --strip-components=1 && \
  git apply keycloak-gsis-providers.diff && \
  mvn package


FROM base

COPY --from=maven-build /code/target/keycloak-gsis-providers-*.jar /opt/keycloak/providers/keycloak-gsis-providers.jar

RUN /opt/keycloak/bin/kc.sh build

# vim: set syntax=dockerfile:
FROM maven:3.9.6-eclipse-temurin-21 as maven-build

ARG keycloak_gsis_providers_version=v3.1.0-keycloak-26

WORKDIR /code
ADD https://github.com/HellenicSpaceCenter/keycloak-gsis-providers/archive/refs/tags/${keycloak_gsis_providers_version}.tar.gz . 
RUN tar xzf ${keycloak_gsis_providers_version}.tar.gz --strip-components=1 && \
  mvn package


FROM base

COPY --from=maven-build /code/target/keycloak-gsis-providers-*.jar /opt/keycloak/providers/keycloak-gsis-providers.jar

RUN /opt/keycloak/bin/kc.sh build

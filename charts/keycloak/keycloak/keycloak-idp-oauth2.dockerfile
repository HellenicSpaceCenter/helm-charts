# vim: set syntax=dockerfile:
FROM maven:3.9.6-eclipse-temurin-17 as maven-build

ARG keycloak_idp_oauth2_version=v0.1

WORKDIR /code
ADD https://github.com/p2-inc/keycloak-idp-oauth2/archive/refs/tags/${keycloak_idp_oauth2_version}.tar.gz .
RUN tar xzf ${keycloak_idp_oauth2_version}.tar.gz --strip-components=1 && mvn package -Djava.version=17


FROM base

COPY --from=maven-build /code/target/keycloak-idp-oauth2-*.jar /opt/keycloak/providers/keycloak-idp-oauth2.jar

RUN /opt/keycloak/bin/kc.sh build

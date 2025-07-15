# vim:set syntax=dockerfile:
FROM base

RUN /opt/keycloak/bin/kc.sh build

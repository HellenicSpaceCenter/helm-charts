# vim:set syntax=dockerfile:

FROM quay.io/keycloak/keycloak:26.3

ARG kc_cache_stack="udp"

ENV \
    KC_DB="postgres" \
    KC_FEATURES="preview" \
    KC_METRICS_ENABLED="true" \
    KC_HEALTH_ENABLED="true" \
    KC_CACHE="ispn" \
    KC_CACHE_STACK=${kc_cache_stack}

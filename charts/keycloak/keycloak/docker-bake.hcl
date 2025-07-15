# vim: set syntax=hcl:

target "base" {
  context = "."
  dockerfile = "./base.dockerfile"
  args = {
    # JGroups discovery mechanism: multicast UDP 
    kc_cache_stack="udp"
  }
}

target "base-on-kubernetes" {
  context = "."
  dockerfile = "./base.dockerfile"
  args = {
    # JGroups discovery mechanism: DNS_PING 
    kc_cache_stack="kubernetes"
  }
}

target "default" {
  context = "."
  dockerfile = "./default.dockerfile"
  contexts = {
    "base" = "target:base"
  }
  tags = [
    "ghcr.io/hellenicspacecenter/keycloak:keycloak",
  ]
}

target "default-on-kubernetes" {
  context = "."
  dockerfile = "./default.dockerfile"
  contexts = {
    "base" = "target:base-on-kubernetes"
  }
  tags = [
    "ghcr.io/hellenicspacecenter/keycloak:keycloak-on-kubernetes",
  ]
}

target "keycloak-idp-oauth2" {
  context = "."
  dockerfile = "./keycloak-idp-oauth2.dockerfile"
  contexts = {
    "base" = "target:base"
  }
  tags = [
    "ghcr.io/hellenicspacecenter/keycloak:keycloak-idp-oauth2",
  ]
}

target "keycloak-idp-oauth2-on-kubernetes" {
  context = "."
  dockerfile = "./keycloak-idp-oauth2.dockerfile"
  contexts = {
    "base" = "target:base-on-kubernetes"
  }
  tags = [
    "ghcr.io/hellenicspacecenter/keycloak:keycloak-idp-oauth2-on-kubernetes",
  ]
}


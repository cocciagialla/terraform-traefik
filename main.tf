# Install traefik helm_chart
resource "helm_release" "traefik" {
  create_namespace = true
  namespace        = "traefik"
  name             = "traefik"
  repository       = "https://helm.traefik.io/traefik"
  chart            = "traefik"
  version          = var.chart_version
  values           = var.values_yaml_body
}

#---------------------------------------------------------------
# Traefik Ingress
#---------------------------------------------------------------

resource "kubectl_manifest" "traefik_middleware_vpn_whitelist" {
  yaml_body = file("${path.module}/confs/middleware_vpn_whitelist.yaml")

  depends_on = [
    helm_release.traefik
  ]
}

resource "kubectl_manifest" "traefik_middleware_basic_auth_secret" {
  yaml_body = templatefile("${path.module}/confs/middleware_basic_auth_secret.yaml", {username = var.basic_auth_username, password = var.basic_auth_password})

  depends_on = [
    helm_release.traefik
  ]
}

resource "kubectl_manifest" "traefik_middleware_basic_auth" {
  yaml_body = file("${path.module}/confs/middleware_basic_auth.yaml")

  depends_on = [
    helm_release.traefik
  ]
}

resource "kubectl_manifest" "traefik_dashboard_ingress_route" {
  yaml_body = templatefile("${path.module}/confs/dashboard_ingress_route.yaml", {
    host = var.host
    enable_websecure = var.enable_websecure
  })

  depends_on = [
    kubectl_manifest.traefik_middleware_vpn_whitelist
  ]
}

resource "kubectl_manifest" "traefik_dashboard_ingress" {
  count = var.dashboard_ingress_yaml_body != "" ? 1 : 0
  yaml_body = var.dashboard_ingress_yaml_body

  depends_on = [
    helm_release.traefik
  ]
}

import Config

strapi_endpoint =
  System.get_env("STRAPI_ENDPOINT") ||
    raise """
    environment variable STRAPI_ENDPOINT is missing.
    """

config :kotkowo, :strapi, endpoint: strapi_endpoint

if System.get_env("PHX_SERVER") do
  config :kotkowo, KotkowoWeb.Endpoint, server: true
end

if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :kotkowo, KotkowoWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base
end

# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ss_chat_service,
  namespace: SSChatService,
  ecto_repos: [SSChatService.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

config :ss_chat_service, SSChatService.Repo,
  migration_primary_key: [name: :id, type: :binary_id]

# Configure the endpoint
config :ss_chat_service, SSChatServiceWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: SSChatServiceWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: SSChatService.PubSub,
  live_view: [signing_salt: "TPOsZxcH"]

# Configure the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :ss_chat_service, SSChatService.Mailer, adapter: Swoosh.Adapters.Local

# Configure Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

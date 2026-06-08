defmodule SSChatService.Repo do
  use Ecto.Repo,
    otp_app: :ss_chat_service,
    adapter: Ecto.Adapters.Postgres
end

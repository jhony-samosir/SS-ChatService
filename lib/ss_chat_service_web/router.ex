defmodule SSChatServiceWeb.Router do
  use SSChatServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug SSChatServiceWeb.Plugs.HmacValidator
  end

  scope "/api", SSChatServiceWeb do
    pipe_through :api

    get "/chat/conversations", ConversationController, :index
    get "/chat/conversations/:id/messages", MessageController, :index
    post "/chat/conversations/:id/messages", MessageController, :create
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ss_chat_service, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: SSChatServiceWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

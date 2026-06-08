defmodule SSChatServiceWeb.Plugs.HmacValidator do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    secret = System.get_env("GATEWAY_HMAC_SECRET") || "secret"
    
    case get_req_header(conn, "x-internal-signature") do
      [signature] ->
        raw_body = conn.assigns[:raw_body] || ""

        expected_sig =
          :crypto.mac(:hmac, :sha256, secret, raw_body)
          |> Base.encode16(case: :lower)

        if expected_sig == String.downcase(signature) do
          conn
        else
          conn
          |> send_resp(:unauthorized, "Invalid HMAC signature")
          |> halt()
        end

      _ ->
        conn
        |> send_resp(:unauthorized, "Missing HMAC signature")
        |> halt()
    end
  end
end

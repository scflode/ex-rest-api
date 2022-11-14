defmodule Plug.JsonErrorRenderer do
  @moduledoc """
  Renders errors for backwards-compatible display in the already established error format.

  The default renderer is in JSON:API style: `OpenApiSpex.Plug.JsonRenderErrorV2`
  """
  @behaviour Plug

  alias OpenApiSpex.OpenApi
  alias Plug.Conn

  @impl Plug
  def init(errors), do: errors

  @impl Plug
  def call(conn, errors) when is_list(errors) do
    response = %{
      message: "Request validation failed",
      violations: Enum.map(errors, &render_error/1)
    }

    json = OpenApi.json_encoder().encode!(response)

    conn
    |> Conn.put_resp_content_type("application/json")
    |> Conn.send_resp(400, json)
  end

  def call(conn, reason) do
    call(conn, [reason])
  end

  defp render_error(error) do
    field = render_field(error.path)

    %{
      "#{field}" => [
        to_string(error)
      ]
    }
  end

  defp render_field([]), do: ""

  defp render_field(path) do
    path |> Enum.map(&to_string/1) |> Path.join()
  end
end

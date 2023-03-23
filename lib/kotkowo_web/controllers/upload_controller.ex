defmodule KotkowoWeb.UploadController do
  use KotkowoWeb, :controller

  import Plug.Conn

  def cat_image_upload(conn, params) do
    IO.inspect(params)

    conn
    |> resp(200, [])
    |> halt()
  end
end

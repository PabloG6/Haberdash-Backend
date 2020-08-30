defmodule Haberdash.Plug.Franchise do
  import Plug.Conn
  require Logger
  alias Haberdash.{Account, Business, Auth}
  def init(opts), do: opts

  def call(conn, _opts) do



    with owner when not is_nil(owner) <- Auth.Guardian.Plug.current_resource(conn),
        {:ok, franchise} <- resource(owner) do
        put_private(conn, :franchise, franchise)
    else
        {:error, :not_found} ->
          Logger.info("No developer found")
          conn
          |>send_resp(:unauthorized, Poison.encode!(%{code: :unauthorized}))

     end

  end

  defp resource(%Account.Owner{id: id}) do
    Business.get_franchise_by(owner_id: id)
  end

  defp resource(%Account.Developer{owner_id: id} = developer) do
    Logger.info("Developer found with owner id: #{id}")
    Kernel.inspect(developer)
    Business.get_franchise_by(owner_id: id)

  end




end

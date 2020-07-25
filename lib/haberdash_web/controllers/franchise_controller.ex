defmodule HaberdashWeb.FranchiseController do
  use HaberdashWeb, :controller

  alias Haberdash.Business
  alias Haberdash.Business.Franchise

  action_fallback HaberdashWeb.FallbackController

  def index(conn, _params) do
    franchise = Business.list_franchises()
    render(conn, "index.json", franchise: franchise)
  end

  def create(conn, %{"franchise" => franchise_params}) do
    with {:ok, %Franchise{} = franchise} <- Business.create_franchise(franchise_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.franchise_path(conn, :show, franchise))
      |> render("show.json", franchise: franchise)
    end
  end

  def show(conn, %{"id" => id}) do
    franchise = Business.get_franchise!(id)
    render(conn, "show.json", franchise: franchise)
  end

  def update(conn, %{"id" => id, "franchise" => franchise_params}) do
    franchise = Business.get_franchise!(id)

    with {:ok, %Franchise{} = franchise} <- Business.update_franchise(franchise, franchise_params) do
      render(conn, "show.json", franchise: franchise)
    end
  end

  def delete(conn, %{"id" => id}) do
    franchise = Business.get_franchise!(id)

    with {:ok, %Franchise{}} <- Business.delete_franchise(franchise) do
      send_resp(conn, :no_content, "")
    end
  end
end

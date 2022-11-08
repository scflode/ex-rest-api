defmodule RestApiWeb.RegistrationController do
  use RestApiWeb, :controller

  alias RestApi.Onboarding
  alias RestApi.Onboarding.Registration

  action_fallback RestApiWeb.FallbackController

  def index(conn, _params) do
    registrations = Onboarding.list_registrations()
    render(conn, :index, registrations: registrations)
  end

  def create(conn, %{"registration" => registration_params}) do
    with {:ok, %Registration{} = registration} <-
           Onboarding.create_registration(registration_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/registrations/#{registration}")
      |> render(:show, registration: registration)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, registration} <- Onboarding.get_registration(id) do
      render(conn, :show, registration: registration)
    end
  end

  def update(conn, %{"id" => id, "registration" => registration_params}) do
    {:ok, registration} = Onboarding.get_registration(id)

    with {:ok, %Registration{} = registration} <-
           Onboarding.update_registration(registration, registration_params) do
      render(conn, :show, registration: registration)
    end
  end

  def delete(conn, %{"id" => id}) do
    {:ok, registration} = Onboarding.get_registration(id)

    with {:ok, %Registration{}} <- Onboarding.delete_registration(registration) do
      send_resp(conn, :no_content, "")
    end
  end
end

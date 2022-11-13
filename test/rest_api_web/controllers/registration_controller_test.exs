defmodule RestApiWeb.RegistrationControllerTest do
  use RestApiWeb.ConnCase

  import RestApi.OnboardingFixtures

  alias RestApi.Onboarding.Registration

  setup %{conn: conn} do
    {:ok,
     conn:
       conn
       |> put_req_header("accept", "application/json")
       |> put_req_header("content-type", "application/json")}
  end

  describe "index" do
    test "lists all registrations", %{conn: conn} do
      conn = get(conn, ~p"/api/registrations")
      assert json_response(conn, 200) == []
    end
  end

  describe "create registration" do
    test "renders registration when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/registrations", valid_request_params())

      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, ~p"/api/registrations/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/registrations", invalid_request_params())
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update registration" do
    setup [:create_registration]

    test "renders registration when data is valid", %{
      conn: conn,
      registration: %Registration{id: id} = registration
    } do
      conn = put(conn, ~p"/api/registrations/#{registration}", update_request_params())
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, ~p"/api/registrations/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, registration: registration} do
      conn = put(conn, ~p"/api/registrations/#{registration}", invalid_request_params())
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_registration(_) do
    registration = registration_fixture()
    %{registration: registration}
  end

  defp valid_request_params(),
    do: OpenApiSpex.Schema.example(RestApiWeb.Schemas.RegistrationParams.schema())

  defp invalid_request_params(),
    do: OpenApiSpex.Schema.example(RestApiWeb.Schemas.InvalidRegistrationParams.schema())

  defp update_request_params(),
    do: OpenApiSpex.Schema.example(RestApiWeb.Schemas.UpdateRegistrationParams.schema())
end

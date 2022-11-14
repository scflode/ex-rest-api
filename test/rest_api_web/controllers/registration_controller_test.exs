defmodule RestApiWeb.RegistrationControllerTest do
  use RestApiWeb.ConnCase

  import OpenApiSpex.TestAssertions
  import RestApi.OnboardingFixtures

  alias RestApi.Onboarding.Registration

  setup %{conn: conn} do
    {:ok,
     conn:
       conn
       |> put_req_header("accept", "application/json")
       |> put_req_header("content-type", "application/json"),
     api_spec: RestApiWeb.ApiSpec.spec()}
  end

  describe "index" do
    test "lists all registrations", %{conn: conn, api_spec: api_spec} do
      json =
        conn
        |> get(~p"/api/registrations")
        |> json_response(200)

      assert_schema(json, "RegistrationsResponse", api_spec)
    end
  end

  describe "create registration" do
    test "renders registration when data is valid", %{conn: conn, api_spec: api_spec} do
      json =
        conn
        |> post(~p"/api/registrations", valid_request_params())
        |> json_response(201)

      assert_schema(json, "RegistrationResponse", api_spec)
      %{"id" => id} = json

      json =
        conn
        |> get(~p"/api/registrations/#{id}", id)
        |> json_response(200)

      assert_schema(json, "RegistrationResponse", api_spec)
    end

    test "renders errors when data is invalid", %{conn: conn, api_spec: api_spec} do
      json =
        conn
        |> post(~p"/api/registrations", invalid_request_params())
        |> json_response(400)

      assert_schema(json, "ErrorResponse", api_spec)
    end
  end

  describe "update registration" do
    setup :create_registration

    test "renders registration when data is valid", %{
      conn: conn,
      api_spec: api_spec,
      registration: %Registration{id: id} = registration
    } do
      json =
        conn
        |> put(~p"/api/registrations/#{registration}", update_request_params())
        |> json_response(200)

      assert_schema(json, "RegistrationResponse", api_spec)

      %{"id" => ^id} = json

      json =
        conn
        |> get(~p"/api/registrations/#{id}")
        |> json_response(200)

      assert_schema(json, "RegistrationResponse", api_spec)
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      api_spec: api_spec,
      registration: registration
    } do
      json =
        conn
        |> put(~p"/api/registrations/#{registration}", invalid_request_params())
        |> json_response(400)

      assert_schema(json, "ErrorResponse", api_spec)
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

defmodule RestApiWeb.RegistrationControllerTest do
  use RestApiWeb.ConnCase

  import RestApi.OnboardingFixtures

  alias RestApi.Onboarding.Registration

  @create_attrs %{
    first_name: "Jane",
    last_name: "Doe"
  }
  @update_attrs %{
    first_name: "Jack",
    last_name: "Done"
  }
  @invalid_attrs %{
    first_name: nil,
    last_name: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all registrations", %{conn: conn} do
      conn = get(conn, ~p"/api/registrations")
      assert json_response(conn, 200) == []
    end
  end

  describe "create registration" do
    test "renders registration when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/registrations", registration: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, ~p"/api/registrations/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/registrations", registration: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update registration" do
    setup [:create_registration]

    test "renders registration when data is valid", %{
      conn: conn,
      registration: %Registration{id: id} = registration
    } do
      conn = put(conn, ~p"/api/registrations/#{registration}", registration: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, ~p"/api/registrations/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, registration: registration} do
      conn = put(conn, ~p"/api/registrations/#{registration}", registration: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete registration" do
    setup [:create_registration]

    test "deletes chosen registration", %{conn: conn, registration: registration} do
      conn = delete(conn, ~p"/api/registrations/#{registration}")
      assert response(conn, 204)

      conn = get(conn, ~p"/api/registrations/#{registration}")
      assert json_response(conn, 404)["errors"] == %{"message" => "Not Found"}
    end
  end

  defp create_registration(_) do
    registration = registration_fixture()
    %{registration: registration}
  end
end

defmodule RestApiWeb.SchemasTest do
  use ExUnit.Case, async: true

  import OpenApiSpex.TestAssertions

  setup do
    {:ok, api_spec: RestApiWeb.ApiSpec.spec()}
  end

  test "Registration matches", %{api_spec: api_spec} do
    schema = RestApiWeb.Schemas.Registration.schema()
    assert_schema(schema.example, "Registration", api_spec)
  end

  test "RegistrationParams matches", %{api_spec: api_spec} do
    schema = RestApiWeb.Schemas.RegistrationParams.schema()
    assert_schema(schema.example, "RegistrationParams", api_spec)
  end

  test "UpdateRegistrationParams matches", %{api_spec: api_spec} do
    schema = RestApiWeb.Schemas.UpdateRegistrationParams.schema()
    assert_schema(schema.example, "UpdateRegistrationParams", api_spec)
  end

  test "RegistrationResponse matches", %{api_spec: api_spec} do
    schema = RestApiWeb.Schemas.RegistrationResponse.schema()
    assert_schema(schema.example, "RegistrationResponse", api_spec)
  end

  test "RegistrationsResponse matches", %{api_spec: api_spec} do
    schema = RestApiWeb.Schemas.RegistrationsResponse.schema()
    assert_schema(schema.example, "RegistrationsResponse", api_spec)
  end

  test "ErrorResponse matches", %{api_spec: api_spec} do
    schema = RestApiWeb.Schemas.ErrorResponse.schema()
    assert_schema(schema.example, "ErrorResponse", api_spec)
  end
end

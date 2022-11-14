defmodule RestApiWeb.RegistrationController do
  use RestApiWeb, :controller
  use OpenApiSpex.ControllerSpecs

  plug OpenApiSpex.Plug.CastAndValidate, json_render_error_v2: true, replace_params: false

  alias OpenApiSpex.{Example, Schema}

  alias RestApiWeb.Schemas.{
    RegistrationParams,
    UpdateRegistrationParams,
    ErrorResponse,
    RegistrationResponse,
    RegistrationsResponse
  }

  alias RestApi.Onboarding
  alias RestApi.Onboarding.Registration

  action_fallback(RestApiWeb.FallbackController)

  tags ["Customer Onboarding"]

  operation :index,
    summary: "List registrations",
    description: """
    Mollit *anim* **incididunt** ~anim~ commodo sunt aute sunt exercitation. Ex
    minim Lorem incididunt aliquip qui duis. Cillum est occaecat do sint velit 
    `officia` sit. Laborum ea sunt consectetur. Dolor elit proident nisi ipsum 
    veniam dolor ea elit pariatur reprehenderit eu sit velit enim et.
    """,
    responses: [
      ok: {"Listing response", "application/json", RegistrationsResponse}
    ]

  def index(conn, _params) do
    registrations = Onboarding.list_registrations()
    render(conn, :index, registrations: registrations)
  end

  operation :create,
    summary: "Create a new registration",
    description: """
    The description for the endpoint...
    """,
    request_body:
      {"Registration params", "application/json", RegistrationParams,
       examples: %{
         a_valid: %Example{
           summary: "Valid input",
           value: %{
             first_name: "Jake",
             last_name: "Fake"
           }
         },
         b_invalid: %Example{
           summary: "Invalid input",
           value: %{
             first_name: 123,
             last_name: 456
           }
         },
         c_incomplete: %Example{
           summary: "Incomplete input",
           value: %{
             first_name: "John"
           }
         }
       }},
    responses: [
      created: {"Created", "application/json", RegistrationResponse},
      bad_request:
        {"Bad request", "application/json", ErrorResponse,
         example: %{
           errors: %{message: "Bad Request"}
         }}
    ]

  def create(conn = %{body_params: params}, _params) do
    with {:ok, %Registration{} = registration} <-
           Onboarding.create_registration(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/registrations/#{registration}")
      |> render(:show, registration: registration)
    end
  end

  operation :show,
    summary: "Show registration",
    description: """
    The description for the endpoint...
    """,
    parameters: [
      id: [
        in: :path,
        type: %Schema{type: :string, format: :uuid},
        description: "Registration ID",
        example: "6e2f869d-f9f4-4902-b7b9-2d37966dc70c",
        required: true
      ]
    ],
    responses: [
      ok: {"The registration", "application/json", RegistrationResponse},
      not_found:
        {"Not found", "application/json", ErrorResponse,
         example: %{
           errors: %{message: "Not Found"}
         }}
    ]

  def show(conn, %{"id" => id}) do
    with {:ok, registration} <- Onboarding.get_registration(id) do
      render(conn, :show, registration: registration)
    end
  end

  operation :update,
    summary: "Update registration",
    description: """
    The description of the update process
    """,
    parameters: [
      id: [
        in: :path,
        type: %Schema{type: :string, format: :uuid},
        description: "Registration ID",
        example: "6e2f869d-f9f4-4902-b7b9-2d37966dc70c",
        required: true
      ]
    ],
    request_body: {"Registration params", "application/json", UpdateRegistrationParams},
    responses: [
      ok: {"The registration", "application/json", RegistrationResponse},
      bad_request:
        {"Bad request", "application/json", ErrorResponse,
         example: %{
           errors: %{message: "Bad Request"}
         }}
    ]

  def update(conn = %{body_params: params}, %{"id" => id}) do
    {:ok, registration} = Onboarding.get_registration(id)

    with {:ok, %Registration{} = registration} <-
           Onboarding.update_registration(registration, params) do
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

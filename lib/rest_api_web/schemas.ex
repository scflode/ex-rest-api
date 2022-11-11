defmodule RestApiWeb.Schemas do
  require OpenApiSpex

  alias OpenApiSpex.Schema

  defmodule Registration do
    OpenApiSpex.schema(%{
      description: "The current state of collected registration data",
      type: :object,
      properties: %{
        id: %Schema{type: :string, format: :uuid},
        first_name: %Schema{type: :string},
        last_name: %Schema{type: :string},
        inserted_at: %Schema{type: :string, format: :"date-time"},
        updated_at: %Schema{type: :string, format: :"date-time"}
      },
      required: [:first_name, :last_name],
      examples: [
        %{
          first_name: "John",
          last_name: "Doe"
        }
      ]
    })
  end

  defmodule RegistrationResponse do
    OpenApiSpex.schema(%{
      description: "Response schema for a single registration",
      type: :object,
      properties: %{
        ref: RestApiWeb.Schemas.Registration
      },
      example: %{
        "id" => "6e2f869d-f9f4-4902-b7b9-2d37966dc70c",
        "first_name" => "Joe User",
        "last_name" => "joe@gmail.com",
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => "2017-09-13T10:11:12Z"
      },
      "x-struct": __MODULE__
    })
  end

  defmodule RegistrationsResponse do
    OpenApiSpex.schema(%{
      description: "The list of registrations",
      type: :array,
      items: RestApiWeb.Schemas.Registration
    })
  end

  defmodule RegistrationParams do
    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        first_name: %Schema{type: :string, description: "The first name"},
        last_name: %Schema{type: :string, description: "The last name"}
      },
      required: [:first_name, :last_name],
      example: %{first_name: "Jake", last_name: "Fake"}
    })
  end

  defmodule ErrorResponse do
    OpenApiSpex.schema(%{
      description: "The error message",
      type: :object,
      properties: %{
        errors: %Schema{
          type: :object,
          description: "The error object containing a message and possible hints",
          properties: %{
            message: %Schema{type: :string, description: "The error message"}
          }
        }
      }
    })
  end
end

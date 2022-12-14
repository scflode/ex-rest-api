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
      example: %{
        id: "778ba3fd-d996-437c-8a2a-c5f17d63b75a",
        first_name: "John",
        last_name: "Doe",
        inserted_at: "2022-11-12T15:33:08Z",
        updated_at: "2022-11-12T15:33:08Z"
      }
    })
  end

  defmodule RegistrationParams do
    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        first_name: %Schema{type: :string, description: "The first name", minLength: 1},
        last_name: %Schema{type: :string, description: "The last name", minLength: 1}
      },
      required: [:first_name, :last_name],
      example: %{first_name: "Jake", last_name: "Fake"}
    })
  end

  defmodule InvalidRegistrationParams do
    OpenApiSpex.schema(%{
      ref: RegistrationParams,
      example: %{first_name: "", last_name: ""}
    })
  end

  defmodule UpdateRegistrationParams do
    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        first_name: %Schema{type: :string, description: "The first name", minLength: 1},
        last_name: %Schema{type: :string, description: "The last name", minLength: 1}
      },
      required: [:first_name, :last_name],
      example: %{first_name: "Jack", last_name: "Brake"}
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
      }
    })
  end

  defmodule RegistrationsResponse do
    OpenApiSpex.schema(%{
      description: "The list of registrations",
      type: :array,
      items: RestApiWeb.Schemas.Registration,
      example: []
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
      },
      example: %{
        errors: %{
          message: "Some error message"
        }
      }
    })
  end
end

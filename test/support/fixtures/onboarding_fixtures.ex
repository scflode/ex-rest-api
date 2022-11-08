defmodule RestApi.OnboardingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestApi.Onboarding` context.
  """

  @doc """
  Generate a registration.
  """
  def registration_fixture(attrs \\ %{}) do
    {:ok, registration} =
      attrs
      |> Enum.into(%{first_name: "Han", last_name: "Solo"})
      |> RestApi.Onboarding.create_registration()

    registration
  end
end

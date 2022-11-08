defmodule RestApiWeb.RegistrationJSON do
  alias RestApi.Onboarding.Registration

  @doc """
  Renders a list of registrations.
  """
  def index(%{registrations: registrations}) do
    for(registration <- registrations, do: data(registration))
  end

  @doc """
  Renders a single registration.
  """
  def show(%{registration: registration}) do
    data(registration)
  end

  defp data(%Registration{} = registration) do
    %{
      id: registration.id
    }
  end
end

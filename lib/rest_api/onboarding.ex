defmodule RestApi.Onboarding do
  @moduledoc """
  The Onboarding context.
  """

  import Ecto.Query, warn: false

  alias RestApi.Repo
  alias RestApi.Onboarding.Registration

  @doc """
  Returns the list of registrations.

  ## Examples

      iex> list_registrations()
      [%Registration{}, ...]

  """
  def list_registrations do
    Repo.all(Registration)
  end

  @doc """
  Gets a single registration or returns an error tuple.

  ## Examples

      iex> get_registration(b9de9971-6f65-41d0-992f-16d33abcbf50)
      {:ok, %Registration{}}

      iex> get_registration(634abcae-3af7-4cce-becd-0349027a5d0e)
      {:error, :not_found}

  """
  def get_registration(id) do
    Registration
    |> Repo.get(id)
    |> case do
      nil -> {:error, :not_found}
      registration -> {:ok, registration}
    end
  end

  @doc """
  Creates a registration.

  ## Examples

      iex> create_registration(%{first_name: "John", last_name: "Doe"})
      {:ok, %Registration{}}

      iex> create_registration(%{first_name: 123})
      {:error, %Ecto.Changeset{}}

  """
  def create_registration(attrs \\ %{}) do
    %Registration{}
    |> Registration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a registration.

  ## Examples

      iex> update_registration(registration, %{field: new_value})
      {:ok, %Registration{}}

      iex> update_registration(registration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_registration(%Registration{} = registration, attrs) do
    registration
    |> Registration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a registration.

  ## Examples

      iex> delete_registration(registration)
      {:ok, %Registration{}}

      iex> delete_registration(registration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_registration(%Registration{} = registration) do
    Repo.delete(registration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking registration changes.

  ## Examples

      iex> change_registration(registration)
      %Ecto.Changeset{data: %Registration{}}

  """
  def change_registration(%Registration{} = registration, attrs \\ %{}) do
    Registration.changeset(registration, attrs)
  end
end

defmodule RestApi.OnboardingTest do
  use RestApi.DataCase

  alias RestApi.Onboarding

  describe "registrations" do
    alias RestApi.Onboarding.Registration

    import RestApi.OnboardingFixtures

    @invalid_attrs %{first_name: 123, last_name: 123}

    test "list_registrations/0 returns all registrations" do
      registration = registration_fixture()
      assert Onboarding.list_registrations() == [registration]
    end

    test "get_registration/1 returns the registration with given id" do
      registration = registration_fixture()
      assert Onboarding.get_registration(registration.id) == {:ok, registration}
    end

    test "create_registration/1 with valid data creates a registration" do
      valid_attrs = %{first_name: "John", last_name: "Doe"}

      assert {:ok, %Registration{}} = Onboarding.create_registration(valid_attrs)
    end

    test "create_registration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Onboarding.create_registration(@invalid_attrs)
    end

    test "update_registration/2 with valid data updates the registration" do
      registration = registration_fixture()
      update_attrs = %{}

      assert {:ok, %Registration{}} = Onboarding.update_registration(registration, update_attrs)
    end

    test "update_registration/2 with invalid data returns error changeset" do
      registration = registration_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Onboarding.update_registration(registration, @invalid_attrs)

      assert {:ok, registration} == Onboarding.get_registration(registration.id)
    end

    test "delete_registration/1 deletes the registration" do
      registration = registration_fixture()
      assert {:ok, %Registration{}} = Onboarding.delete_registration(registration)
      assert {:error, :not_found} = Onboarding.get_registration(registration.id)
    end

    test "change_registration/1 returns a registration changeset" do
      registration = registration_fixture()
      assert %Ecto.Changeset{} = Onboarding.change_registration(registration)
    end
  end
end

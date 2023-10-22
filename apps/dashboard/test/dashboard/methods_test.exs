defmodule Dashboard.MethodsTest do
  use Dashboard.DataCase

  alias Dashboard.Methods

  describe "compound_interests" do
    alias Dashboard.Methods.CompoundInterest

    import Dashboard.MethodsFixtures

    @invalid_attrs %{anual_rate: nil, periods: nil, principal_amount: nil}

    test "list_compound_interests/0 returns all compound_interests" do
      compound_interest = compound_interest_fixture()
      assert Methods.list_compound_interests() == [compound_interest]
    end

    test "get_compound_interest!/1 returns the compound_interest with given id" do
      compound_interest = compound_interest_fixture()
      assert Methods.get_compound_interest!(compound_interest.id) == compound_interest
    end

    test "create_compound_interest/1 with valid data creates a compound_interest" do
      valid_attrs = %{anual_rate: 120.5, periods: 42, principal_amount: 42}

      assert {:ok, %CompoundInterest{} = compound_interest} = Methods.create_compound_interest(valid_attrs)
      assert compound_interest.anual_rate == 120.5
      assert compound_interest.periods == 42
      assert compound_interest.principal_amount == 42
    end

    test "create_compound_interest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Methods.create_compound_interest(@invalid_attrs)
    end

    test "update_compound_interest/2 with valid data updates the compound_interest" do
      compound_interest = compound_interest_fixture()
      update_attrs = %{anual_rate: 456.7, periods: 43, principal_amount: 43}

      assert {:ok, %CompoundInterest{} = compound_interest} = Methods.update_compound_interest(compound_interest, update_attrs)
      assert compound_interest.anual_rate == 456.7
      assert compound_interest.periods == 43
      assert compound_interest.principal_amount == 43
    end

    test "update_compound_interest/2 with invalid data returns error changeset" do
      compound_interest = compound_interest_fixture()
      assert {:error, %Ecto.Changeset{}} = Methods.update_compound_interest(compound_interest, @invalid_attrs)
      assert compound_interest == Methods.get_compound_interest!(compound_interest.id)
    end

    test "delete_compound_interest/1 deletes the compound_interest" do
      compound_interest = compound_interest_fixture()
      assert {:ok, %CompoundInterest{}} = Methods.delete_compound_interest(compound_interest)
      assert_raise Ecto.NoResultsError, fn -> Methods.get_compound_interest!(compound_interest.id) end
    end

    test "change_compound_interest/1 returns a compound_interest changeset" do
      compound_interest = compound_interest_fixture()
      assert %Ecto.Changeset{} = Methods.change_compound_interest(compound_interest)
    end
  end
end

defmodule Bank.AccountsTest do
  use Bank.DataCase

  alias Bank.Accounts

  describe "accounts" do
    alias Bank.Accounts.Account

    @valid_attrs %{birth_date: ~D[2010-04-17], city: "some city", country: "some country", cpf: "some cpf", email: "some email", gender: "some gender", name: "some name", referral_code: 42, state: "some state"}
    @update_attrs %{birth_date: ~D[2011-05-18], city: "some updated city", country: "some updated country", cpf: "some updated cpf", email: "some updated email", gender: "some updated gender", name: "some updated name", referral_code: 43, state: "some updated state"}
    @invalid_attrs %{birth_date: nil, city: nil, country: nil, cpf: nil, email: nil, gender: nil, name: nil, referral_code: nil, state: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Accounts.create_account(@valid_attrs)
      assert account.birth_date == ~D[2010-04-17]
      assert account.city == "some city"
      assert account.country == "some country"
      assert account.cpf == "some cpf"
      assert account.email == "some email"
      assert account.gender == "some gender"
      assert account.name == "some name"
      assert account.referral_code == 42
      assert account.state == "some state"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %Account{} = account} = Accounts.update_account(account, @update_attrs)
      assert account.birth_date == ~D[2011-05-18]
      assert account.city == "some updated city"
      assert account.country == "some updated country"
      assert account.cpf == "some updated cpf"
      assert account.email == "some updated email"
      assert account.gender == "some updated gender"
      assert account.name == "some updated name"
      assert account.referral_code == 43
      assert account.state == "some updated state"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end

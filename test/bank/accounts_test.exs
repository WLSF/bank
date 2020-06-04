defmodule Bank.AccountsTest do
  use Bank.DataCase

  alias Bank.Accounts
  alias Bank.Repo

  describe "accounts" do
    alias Bank.Accounts.Account

    @valid_attrs %{birth_date: ~D[2010-04-17], city: "some city", country: "some country", cpf: "02390213285", email: "some@email.com", gender: "some gender", name: "some name", state: "some state"}
    @update_attrs %{birth_date: ~D[2011-05-18], city: "some updated city", country: "some updated country", cpf: "02390213285", email: "someupdated@email.com", gender: "some updated gender", name: "some updated name", state: "some updated state"}
    @invalid_attrs %{cpf: nil, email: "nil"}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_or_update_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "create_or_update_account/1 with valid data creates an account" do
      assert {:ok, %Account{} = account} = Accounts.create_or_update_account(@valid_attrs)
      assert account.birth_date == ~D[2010-04-17]
      assert account.city == "some city"
      assert account.country == "some country"
      assert account.cpf == "02390213285"
      assert account.email == "some@email.com"
      assert account.gender == "some gender"
      assert account.name == "some name"
      assert account.state == "some state"
    end

    test "create_or_update_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_or_update_account(@invalid_attrs)
    end

    test "create_or_update_account/1 with valid data updates the account" do
      assert {:ok, %Account{} = account} = Accounts.create_or_update_account(@update_attrs)
      assert account.birth_date == ~D[2011-05-18]
      assert account.city == "some updated city"
      assert account.country == "some updated country"
      assert account.cpf == "02390213285"
      assert account.email == "someupdated@email.com"
      assert account.gender == "some updated gender"
      assert account.name == "some updated name"
      assert account.state == "some updated state"
    end

    test "create_or_update_account/1 update with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.create_or_update_account(@invalid_attrs)
      assert account == Repo.get!(Account, account.id)
    end
  end
end

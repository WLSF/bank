defmodule BankWeb.AccountControllerTest do
  use BankWeb.ConnCase

  alias Bank.Accounts
  alias Bank.Accounts.Account

  @create_attrs %{
    birth_date: ~D[2010-04-17],
    city: "some city",
    country: "some country",
    cpf: "some cpf",
    email: "some email",
    gender: "some gender",
    name: "some name",
    referral_code: 42,
    state: "some state"
  }
  @update_attrs %{
    birth_date: ~D[2011-05-18],
    city: "some updated city",
    country: "some updated country",
    cpf: "some updated cpf",
    email: "some updated email",
    gender: "some updated gender",
    name: "some updated name",
    referral_code: 43,
    state: "some updated state"
  }
  @invalid_attrs %{birth_date: nil, city: nil, country: nil, cpf: nil, email: nil, gender: nil, name: nil, referral_code: nil, state: nil}

  def fixture(:account) do
    {:ok, account} = Accounts.create_account(@create_attrs)
    account
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.account_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2010-04-17",
               "city" => "some city",
               "country" => "some country",
               "cpf" => "some cpf",
               "email" => "some email",
               "gender" => "some gender",
               "name" => "some name",
               "referral_code" => 42,
               "state" => "some state"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{conn: conn, account: %Account{id: id} = account} do
      conn = put(conn, Routes.account_path(conn, :update, account), account: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.account_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2011-05-18",
               "city" => "some updated city",
               "country" => "some updated country",
               "cpf" => "some updated cpf",
               "email" => "some updated email",
               "gender" => "some updated gender",
               "name" => "some updated name",
               "referral_code" => 43,
               "state" => "some updated state"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, Routes.account_path(conn, :update, account), account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, Routes.account_path(conn, :delete, account))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.account_path(conn, :show, account))
      end
    end
  end

  defp create_account(_) do
    account = fixture(:account)
    %{account: account}
  end
end

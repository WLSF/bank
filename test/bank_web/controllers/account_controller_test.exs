defmodule BankWeb.AccountControllerTest do
  use BankWeb.ConnCase

  alias BankWeb.Repositories.Accounts

  @create_attrs %{
    birth_date: ~D[2010-04-17],
    city: "some city",
    country: "some country",
    cpf: "13451520",
    email: "some@email.com",
    gender: "some gender",
    name: "some name",
    state: "some state"
  }
  @update_attrs %{
    birth_date: ~D[2011-05-18],
    city: "some updated city",
    country: "some updated country",
    cpf: "13451520",
    email: "someupdated@email.com",
    gender: "some updated gender",
    name: "some updated name",
    state: "some updated state"
  }
  @invalid_attrs %{birth_date: nil, city: nil, country: nil, cpf: nil, email: "email", gender: nil, name: nil, referral_code: nil, state: nil}

  def fixture(:account) do
    {:ok, account} = Accounts.create_or_update_account(@create_attrs)
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

      response = json_response(conn, 201)["data"]

      assert %{
               "id" => id,
               "birth_date" => "2010-04-17",
               "city" => "some city",
               "country" => "some country",
               "cpf" => "13451520",
               "email" => "some@email.com",
               "gender" => "some gender",
               "name" => "some name",
               "state" => "some state"
             } = response

      assert response["referral_code"] != nil
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @update_attrs)

      response = json_response(conn, 201)["data"]

      assert %{
               "id" => id,
               "birth_date" => "2011-05-18",
               "city" => "some updated city",
               "country" => "some updated country",
               "cpf" => "13451520",
               "email" => "someupdated@email.com",
               "gender" => "some updated gender",
               "name" => "some updated name",
               "state" => "some updated state"
             } = response

      assert response["referral_code"] != nil
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_account(_) do
    account = fixture(:account)
    %{account: account}
  end
end

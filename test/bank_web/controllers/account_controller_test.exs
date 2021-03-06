defmodule BankWeb.AccountControllerTest do
  use BankWeb.ConnCase

  alias Bank.Factory

  @create_attrs %{
    birth_date: ~D[2010-04-17],
    city: "some city",
    country: "some country",
    cpf: "123.456.789-00",
    email: "some@email.com",
    gender: "some gender",
    name: "some name",
    state: "some state"
  }
  @update_attrs %{
    birth_date: ~D[2011-05-18],
    city: "some updated city",
    country: "some updated country",
    cpf: "987.654.321-00",
    email: "someupdated@email.com",
    gender: "some updated gender",
    name: "some updated name",
    state: "some updated state"
  }
  @invalid_attrs %{birth_date: nil, city: nil, country: nil, cpf: nil, email: "email", gender: nil, name: nil, referral_code: nil, state: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "login" do
    test "using a valid account", %{conn: conn} do
      account = Factory.insert!(:account)
      conn = post(conn, Routes.account_path(conn, :login), %{email: account.email, cpf: account.cpf})
      response = json_response(conn, 200)
      assert response["jwt"] != nil
    end

    test "using an invalid account", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :login), %{email: "emailqualquer@oi.com", cpf: "cpf_qualquer"})
      response = json_response(conn, 401)
      assert response["message"] =~ "Login incorreto"
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
               "cpf" => "123.456.789-00",
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
               "cpf" => "987.654.321-00",
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
    account = Factory.insert!(:account)
    %{account: account}
  end
end

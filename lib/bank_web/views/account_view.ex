defmodule BankWeb.AccountView do
  use BankWeb, :view
  alias BankWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id,
      name: account.name,
      email: account.email,
      cpf: account.cpf,
      birth_date: account.birth_date,
      gender: account.gender,
      city: account.city,
      state: account.state,
      country: account.country,
      referral_code: account.referral_code,
      status: get_status(account)}
  end
end

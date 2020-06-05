defmodule Bank.Factory do
  alias Bank.Repo
  alias BankWeb.Models.{
    Account,
    Indication
  }

  def build(:account) do
    %Account{birth_date: ~D[2010-04-17], city: "some city", country: "some country", cpf: "123.456.789-00", email: "some@email.com", gender: "some gender", name: "some name", state: "some state"}
  end

  def build(:indication) do
    #%Indication{sender} still thinking about it
  end

  def build(factory, attrs \\ []), do: factory |> build() |> struct(attrs)
  def insert!(factory, attrs \\ []), do: factory |> build(attrs) |> Repo.insert!()
end

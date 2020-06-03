defmodule BankWeb.IndicationsView do
  use BankWeb, :view
  alias BankWeb.IndicationsView

  def render("index.json", %{indications: indications}) do
    %{data: render_many(indications, IndicationsView, "indication.json")}
  end

  def render("indication.json", %{indications: indication}) do
    {id, name} = indication
    %{id: id,
      name: name}
  end
end

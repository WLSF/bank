defmodule BankWeb.Utils.InvitationCodeGenerator do
  import Ecto.UUID, only: [generate: 0]

  def call() do
    {number, _} = generate()
    |> String.split(~r"[^\d]")
    |> List.to_string()
    |> String.slice(0..7)
    |> Integer.parse()
    
    number
  end
end
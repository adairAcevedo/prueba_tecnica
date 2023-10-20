defmodule Api.Apicore do
  @capitalization_interest 1
  # amount = 5000 anual_rate = 0.05, periods = 36
  def calculate_compound_interest(principal_amount, anual_rate, periods) do
    # amount * (1+ :math.pow((anual_rate/@capitalization_interest),(@capitalization_<interest*periods))) |> Float.round(2) # calculo de git
    principal_amount * (:math.pow((1+ anual_rate)/@capitalization_interest,(@capitalization_interest*periods)))
    # |> :erlang.float_to_binary([{:decimals, 2}])
    |> Float.round(2) # ajuste calculo
  end

  def generate_random_key do
    for _ <- 1..32, into: "", do: <<Enum.random('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz')>>
  end

end

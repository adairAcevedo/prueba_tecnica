defmodule Api.Apicore do
  @capitalization_interest 1
  # amount = 5000 anual_rate = 0.05, periods = 36
  def calculate_compound_interest(principal_amount, anual_rate, periods) do
    # amount * (1+ :math.pow((anual_rate/@capitalization_interest),(@capitalization_interest*periods))) |> Float.round(2) # calculo de git
    principal_amount * (:math.pow((1+ anual_rate)/@capitalization_interest,(@capitalization_interest*periods))) |> Float.round(2) # ajuste calculo
  end


end

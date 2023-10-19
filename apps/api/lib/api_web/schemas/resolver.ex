defmodule ApiWeb.Resolvers.CounpontInterest do

  def calculate(_query,args,_context) do
    # {:ok, Api.Apicore.test_calculate(args.principal, args.anual_rate, args.periods)}
    {:ok,
      %{
        amount_total: Api.Apicore.calculate_compound_interest(args.principal, args.anual_rate, args.periods),
        request_detailed: %{
          principal: args.principal,
          anual_rate: args.anual_rate,
          periods: args.periods
        }
      }
    }
  end
end

defmodule ApiWeb.Schema do
   use Absinthe.Schema
  #  use Absinthe.Schema.Notation
   import_types Absinthe.Plug.Types

   object :request_detailed do
      field :principal, :integer
      field :anual_rate, :float
      field :periods, :integer
   end

   object :resp_compound_interest do
      field :amount_total, :float
      field :request_detailed, :request_detailed
   end

   query do
      field :calculate_compound_interest, :resp_compound_interest do
        arg :principal, non_null(:integer)
        arg :anual_rate, non_null(:float)
        arg :periods, non_null(:integer)
        resolve &ApiWeb.Resolvers.CounpontInterest.calculate/3
      end
   end

end

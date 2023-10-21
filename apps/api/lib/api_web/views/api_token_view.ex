defmodule ApiWeb.ApiTokenView do

  def render("api_token.json", %{response: response}) do
    %{
      "token" => response.token
    }
  end

  def render("api_tokens.json", %{response: response}) do
    Enum.reduce(response, [],fn (api_token, acc) ->
      acc ++ [
        %{
          "token" => api_token.token
        }
      ]
    end)
  end

  def render("error.json", %{error: error}) do
    error
  end

end

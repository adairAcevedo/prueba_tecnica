# PruebaTecnica

**TODO: Add description**
- Elixir 1.15.7-otp-24
- Erlang 24.0.2
- PostgrestSql 14.9
- NodeJs 12.22.9

> If you use package manager like [asdf](https://asdf-vm.com/) you can use it.

### Steps to config project enviroment
1. Set enviroment in `.env` file and run `source .env`
2. Install all dependences to Elixi project with `mix deps.get`
3. Go to apps/api un run command `mix setup` to create Db
4. Run proyect with `mix phx.server`


Apitoken default  "kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy"
Api token limit 40 requests per hour

Api routes Examples

Compound Interest
```bash
curl --request POST \
  --url http://localhost:4001/calcular-intereses \
  --header 'Content-Type: application/json' \
  --header 'User-Agent: insomnia/8.3.0' \
  --header 'X-API-TOKEN: kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy' \
  --data '{
  "principal": 1000,
  "tasa_anual": 0.05,
  "periodos": 1
}'
```

Jokes
```bash
curl --request GET \
  --url http://localhost:4001/jokes/random \
  --header 'User-Agent: insomnia/8.3.0' \
  --header 'x-api-token: kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy'
```

Weather
```bash
curl --request GET \
  --url http://localhost:4001/weather/cancun \
  --header 'User-Agent: insomnia/8.3.0' \
  --header 'x-api-token: kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy'
```

# PruebaTecnica

**TODO: Add description**
- Elixir 1.15.7-otp-24
- Erlang 24.0.2
- PostgrestSql 14.9
- NodeJs 12.22.9

> If you use package manager like [asdf](https://asdf-vm.com/) you can use it.

Steps to config project enviroment
    1 Set enviroment in `.env` file and run `source .env`
    2 Install all dependences to Elixi project with `mix deps.get`
    3 Go to apps/api un run command `mix setup` to create Db and insert demo data
    4 Run proyect with `mix phx.server`


Apitoken default  "kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy"

Api routes 

post http://localhost:4000/calcular-intereses

get http://localhost:4000/jokes/random


header required  X-API-TOKEN

limit request 20 per api-token

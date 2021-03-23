# Rocketpay

## Next Level Week #4 project

### Simple api to run transactions among users
- Allow to create users
- With authenticated routes, it allow transactions (send money, check balance) among users
- **Some points of attention:** it uses basic_auth, for studying purpose, it should use JWT at least. Also the credentials are testing ones, so that's why it is hardcoded and not in environment variables.

### Technologies
- API Created with Elixir and Phoenix, using Ecto and Postgres DB
- For tests, it uses _excoveralls_

### Pending points:
  - [ ]  Cover all application with tests and achieve 100% in coveralls.html [by running `mix test --cover`  or  `mix coveralls.html`] - currently it has 60.6% covered 
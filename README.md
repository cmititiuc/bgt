# OpenmaizePhoenixBoilerplate

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Command History

mix phoenix.new openmaize_phoenix_boilerplate
cd openmaize_phoenix_boilerplate/
mix archive.install https://github.com/riverrun/openmaize/raw/master/installer/archives/openmaize_phx-2.8.0.ez
mix openmaize.phx

*add openmaize to deps and applications in mix.exs*
{:openmaize, "~> 2.8"}
:openmaize

mix deps.get
mix ecto.setup
npm install
iex -S mix phoenix.server

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

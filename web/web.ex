defmodule Bgt.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Bgt.Web, :controller
      use Bgt.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Bgt.Repo
      import Ecto
      import Ecto.Query

      import Bgt.Router.Helpers
      import Bgt.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Bgt.Router.Helpers
      import Bgt.ErrorHelpers
      import Bgt.Gettext

      defp time_zone_convert(datetime) do
        timezone = Timex.Timezone.get("America/New_York", Timex.now)
        Timex.Timezone.convert(datetime, timezone)
      end

      def format_date(datetime) do
        datetime |> time_zone_convert |> Timex.format!("{WDshort}, {Mshort} {D}, {YYYY}")
      end

      def format_time(datetime) do
        datetime |> time_zone_convert |> Timex.format!("{h12}:{m} {AM}")
      end
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Bgt.Repo
      import Ecto
      import Ecto.Query
      import Bgt.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end

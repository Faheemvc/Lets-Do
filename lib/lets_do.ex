defmodule LetsDo do
  @moduledoc """
  LetsDo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def view do
    quote do
      use Phoenix.View,
        root: "lib/lets_do_web/templates",
        namespace: LetsDoWeb

      # Import functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Import all HTML functionality (forms, tags, etc.)
      use Phoenix.HTML

      # Import helpers
      import LetsDoWeb.Router.Helpers
      import LetsDoWeb.ErrorHelpers
      import LetsDoWeb.Gettext
    end
  end
end

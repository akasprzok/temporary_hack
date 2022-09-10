defmodule TemporaryHackWeb.Components.About do
  @moduledoc """
  A surface component for the "about" section on the main page.

  There's only one of these, but breaking this out helps organize the code better.
  """
  use Surface.Component

  alias TemporaryHackWeb.Components.Icons

  def render(assigns) do
    ~F"""
    <section class="top-0 flex-wrap justify-between md:justify-start items-center gap-2 px-4 pt-4">
      <div class="w-64 h-64 mx-auto max-w-full">
        <img class="rounded-6xl" src="/images/andreas_green_mustache.jpeg">
      </div>
      <div class="w-64 mt-4 pb-6 mx-auto">
        <h1 class="text-xl text-center">Hi, I'm Andreas Kasprzok</h1>

        <div class="pt-1 gap-2 mt-2 flex flex-row justify-center">
          <a class="flex flex-1" href="https://twitter.com/akasprzok">
            <Icons.Twitter />
          </a>
          <a class="flex flex-1" href="https://github.com/akasprzok">
            <Icons.Github />
          </a>
          <a class="flex flex-1" href="https://www.linkedin.com/in/akasprzok/">
            <Icons.Linkedin />
          </a>
        </div>
      </div>
    </section>
    """
  end
end

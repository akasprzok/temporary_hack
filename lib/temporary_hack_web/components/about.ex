defmodule TemporaryHackWeb.Components.About do
  @moduledoc """
  A surface component for the "about" section on the main page.

  There's only one of these, but breaking this out helps organize the code better.
  """
  use Surface.Component

  alias TemporaryHackWeb.Components.Icons

  def render(assigns) do
    ~F"""
    <section class="top-0 flex flex-wrap justify-between md:justify-start items-center gap-2 px-4 pt-4">
      <div class="w-80 md:h-64 md:w-64 mx-auto max-w-full">
        <img class="rounded-full" src="/images/andreas_green_mustache.jpeg">
      </div>
      <div class="w-full mt-4 pb-6">
        <h1 class="text-xl text-center">Hi, I'm Andreas Kasprzok</h1>
        <div class="pt-2 gap-2 mt-2 flex flex-row justify-center">
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

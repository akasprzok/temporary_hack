alias TemporaryHack.Users

Users.create_admin!(%{
  email: "admin@admin.com",
  password: "adminadmin",
  password_confirmation: "adminadmin"
})

Users.create_user(%{
  email: "user@user.com",
  password: "useruser",
  password_confirmation: "useruser"
})

alias TemporaryHack.Blog

{:ok, _} =
  Blog.create_post(%{
    title: "Hello World",
    body: "ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn"
  })

{:ok, _} =
  Blog.create_post(%{
    title: "I am a blog post",
    body:
      "It is good to have an end to journey toward; but it is the journey that matters, in the end."
  })

{:ok, _} =
  Blog.create_post(%{
    title: "I am a long blog post",
    body:
      "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used before final copy is available, but it may also be used to temporarily replace copy in a process called greeking, which allows designers to consider form without the meaning of the text influencing the design.
  Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a first-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical, improper Latin.
  Versions of the Lorem ipsum text have been used in typesetting at least since the 1960s, when it was popularized by advertisements for Letraset transfer sheets. Lorem ipsum was introduced to the digital world in the mid-1980s when Aldus employed it in graphic and word-processing templates for its desktop publishing program PageMaker. Other popular word processors including Pages and Microsoft Word have since adopted Lorem ipsum as well."
  })

alias TemporaryHack.Frontpage

[
  "Click Me!",
  "Guaranteed Java-free!",
  "Yeet!",
  "Built with Elixir and Phoenix"
]
|> Enum.map(&%{text: &1})
|> Enum.each(&Frontpage.create_tagline!/1)

alias TemporaryHack.ProCon

{:ok, pro_con_list} = ProCon.create_pro_con_list(%{title: "Denver?"})

{:ok, _pro} =
  ProCon.insert_item(%{
    pro_con_list_id: pro_con_list.id,
    type: "pro",
    weight: 3,
    name: "Cuyler and Seth"
  })

{:ok, _con} =
  ProCon.insert_item(%{
    pro_con_list_id: pro_con_list.id,
    type: "con",
    weight: 2,
    name: "Landlocked"
  })

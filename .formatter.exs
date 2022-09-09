[
  import_deps: [:phoenix, :surface],
  inputs: [
    "*.{ex,exs}",
    "priv/*/seeds.exs",
    "{config,lib,test}/**/*.{ex,exs}",
    "{lib,test}/**/*.sface"
  ],
  plugins: [Surface.Formatter.Plugin]
]

%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/"],
        excluded: ["lib/rfc2822/datetime_parsec.ex"]
      }
    }
  ]
}

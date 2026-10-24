let
  Source = Excel.Workbook(File.Contents("datasets\raw_tables.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "security", Kind = "Sheet"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 1", {{"Column1", type text}, {"Column2", type text}}, "en-US"),
    #"Promoted Headers" = Table.PromoteHeaders(#"Changed column type", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"UserEmail", type text}, {"Region", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Region", "region"}, {"UserEmail", "user_email"}})
in
  #"Renamed Columns"

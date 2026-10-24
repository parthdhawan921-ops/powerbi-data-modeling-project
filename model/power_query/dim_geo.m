let
    Source = cities,
    #"Added Index" = Table.AddIndexColumn(Source, "Index", 1, 1, Int64.Type),
    #"Renamed Columns" = Table.RenameColumns(#"Added Index",{{"Index", "geo_key"}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Renamed Columns",{"geo_key", "CityName", "RegionName"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Reordered Columns",{{"CityName", "city"}, {"RegionName", "region"}})
in
    #"Renamed Columns1"

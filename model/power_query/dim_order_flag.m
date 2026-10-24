let
    Source = orders,
    #"Removed Other Columns" = Table.SelectColumns(Source,{"OrderChannel", "Status", "Priority"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns"),
    #"Added Index" = Table.AddIndexColumn(#"Removed Duplicates", "Index", 1, 1, Int64.Type),
    #"Renamed Columns" = Table.RenameColumns(#"Added Index",{{"Index", "flag_key"}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Renamed Columns",{"flag_key", "OrderChannel", "Status", "Priority"}),
    #"Merged Queries" = Table.NestedJoin(#"Reordered Columns", {"OrderChannel"}, Channels, {"channel_code"}, "Channels", JoinKind.LeftOuter),
    #"Expanded Channels" = Table.ExpandTableColumn(#"Merged Queries", "Channels", {"channel_name"}, {"channel_name"}),
    #"Reordered Columns1" = Table.ReorderColumns(#"Expanded Channels",{"flag_key", "OrderChannel", "channel_name", "Status", "Priority"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Reordered Columns1",{{"Status", "status"}, {"Priority", "priority"}, {"OrderChannel", "channel_code"}})
in
    #"Renamed Columns1"

let
    Source = CAMPAIGN_LOG,
    #"Removed Other Columns" = Table.SelectColumns(Source,{"CampaignName", "Channel", "StartDate", "EndDate", "Budget"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns"),
    #"Added Index" = Table.AddIndexColumn(#"Removed Duplicates", "Index", 1, 1, Int64.Type),
    #"Renamed Columns" = Table.RenameColumns(#"Added Index",{{"Index", "campaign_key"}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Renamed Columns",{"campaign_key", "CampaignName", "Channel", "StartDate", "EndDate", "Budget"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Reordered Columns",{{"CampaignName", "campaign_name"}, {"Channel", "channel"}, {"StartDate", "start_date"}, {"EndDate", "end_date"}, {"Budget", "budget"}})
in
    #"Renamed Columns1"

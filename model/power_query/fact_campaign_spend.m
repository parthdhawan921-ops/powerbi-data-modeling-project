let
    Source = CAMPAIGN_LOG,
    #"Merged Queries" = Table.NestedJoin(Source, {"CampaignName"}, dim_campaign, {"campaign_name"}, "dim_campaign", JoinKind.LeftOuter),
    #"Expanded dim_campaign" = Table.ExpandTableColumn(#"Merged Queries", "dim_campaign", {"campaign_key"}, {"campaign_key"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Expanded dim_campaign",{"campaign_key", "CampaignName", "Channel", "StartDate", "EndDate", "Budget", "Date", "Impressions", "Clicks", "Spend"}),
    #"Removed Columns" = Table.RemoveColumns(#"Reordered Columns",{"CampaignName", "Channel", "StartDate", "EndDate", "Budget"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"Clicks", "clicks"}, {"Impressions", "impressions"}, {"Date", "date"}})
in
    #"Renamed Columns"

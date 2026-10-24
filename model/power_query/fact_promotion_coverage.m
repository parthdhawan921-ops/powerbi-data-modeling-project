let
    Source = campaign_skus,
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"CampaignName", type text}, {"PromotedSKUs", type text}}),
    #"Split Column by Delimiter" = Table.ExpandListColumn(Table.TransformColumns(#"Changed Type", {{"PromotedSKUs", Splitter.SplitTextByDelimiter(",", QuoteStyle.Csv), let itemType = (type nullable text) meta [Serialized.Text = true] in type {itemType}}}), "PromotedSKUs"),
    #"Changed Type1" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"PromotedSKUs", type text}}),
    #"Trimmed Text" = Table.TransformColumns(#"Changed Type1",{{"PromotedSKUs", Text.Trim, type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Trimmed Text",{{"CampaignName", "campaign_name"}, {"PromotedSKUs", "promoted_skus"}}),
    #"Merged Queries" = Table.NestedJoin(#"Renamed Columns", {"campaign_name"}, dim_campaign, {"campaign_name"}, "dim_campaign", JoinKind.LeftOuter),
    #"Expanded dim_campaign" = Table.ExpandTableColumn(#"Merged Queries", "dim_campaign", {"campaign_key"}, {"campaign_key"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Expanded dim_campaign",{"campaign_key", "campaign_name", "promoted_skus"}),
    #"Removed Columns" = Table.RemoveColumns(#"Reordered Columns",{"campaign_name"}),
    #"Merged Queries1" = Table.NestedJoin(#"Removed Columns", {"promoted_skus"}, dim_product, {"product_code"}, "dim_product", JoinKind.LeftOuter),
    #"Expanded dim_product" = Table.ExpandTableColumn(#"Merged Queries1", "dim_product", {"product_key"}, {"product_key"}),
    #"Removed Columns1" = Table.RemoveColumns(#"Expanded dim_product",{"promoted_skus"})
in
    #"Removed Columns1"

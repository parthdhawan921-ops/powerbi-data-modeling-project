let
    Source = inventory,
    #"Unpivoted Other Columns" = Table.UnpivotOtherColumns(Source, {"ProductName"}, "Attribute", "Value"),
    #"Changed Type" = Table.TransformColumnTypes(#"Unpivoted Other Columns",{{"Attribute", type date}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"ProductName"}, dim_product, {"product_name"}, "dim_product", JoinKind.LeftOuter),
    #"Expanded dim_product" = Table.ExpandTableColumn(#"Merged Queries", "dim_product", {"product_key"}, {"product_key"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Expanded dim_product",{"product_key", "ProductName", "Attribute", "Value"}),
    #"Removed Columns" = Table.RemoveColumns(#"Reordered Columns",{"ProductName"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"Attribute", "month"}, {"Value", "units"}})
in
    #"Renamed Columns"

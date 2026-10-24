let
    Source = products,
    #"Filtered Rows1" = Table.SelectRows(Source, each ([source_id] <> "SAP-099001" and [source_id] <> "SAP-099002") and ([ProductCode] <> "ZZZ-000")),
    #"Filtered Rows" = Table.SelectRows(#"Filtered Rows1", each ([ProductCode] <> "ELE-901" and [ProductCode] <> "HOM-902" and [ProductCode] <> "ZZZ-000")),
    #"Merged Queries" = Table.NestedJoin(#"Filtered Rows", {"SubcategoryName"}, subcategories, {"subcategory"}, "subcategories", JoinKind.LeftOuter),
    #"Expanded subcategories" = Table.ExpandTableColumn(#"Merged Queries", "subcategories", {"category"}, {"category"}),
    #"Added Index" = Table.AddIndexColumn(#"Expanded subcategories", "Index", 1, 1, Int64.Type),
    #"Reordered Columns" = Table.ReorderColumns(#"Added Index",{"Index", "ProductCode", "ProductName", "Brand", "SubcategoryName", "UnitPrice", "PrimarySupplier", "ProductDescription", "hash_key", "source_id", "category"}),
    #"Renamed Columns" = Table.RenameColumns(#"Reordered Columns",{{"Index", "product_key"}}),
    #"Removed Columns" = Table.RemoveColumns(#"Renamed Columns",{"hash_key", "ProductDescription", "source_id"}),
    #"Reordered Columns1" = Table.ReorderColumns(#"Removed Columns",{"product_key", "ProductCode", "ProductName", "Brand", "SubcategoryName", "category", "UnitPrice", "PrimarySupplier"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Reordered Columns1",{{"ProductCode", "product_code"}, {"ProductName", "product_name"}, {"Brand", "brand"}, {"SubcategoryName", "subcategory"}}),
    #"Capitalized Each Word" = Table.TransformColumns(#"Renamed Columns1",{{"category", Text.Proper, type text}}),
    #"Renamed Columns2" = Table.RenameColumns(#"Capitalized Each Word",{{"UnitPrice", "unit_price"}, {"PrimarySupplier", "supplier"}})
in
    #"Renamed Columns2"

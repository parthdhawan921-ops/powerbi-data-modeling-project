let
    Source = orders,
    #"Removed Other Columns" = Table.SelectColumns(Source,{"OrderID", "CustomerName", "OrderDate"}),
    #"Merged Queries" = Table.NestedJoin(#"Removed Other Columns", {"CustomerName"}, dim_customer, {"customer_name"}, "dim_customer", JoinKind.LeftOuter),
    #"Expanded dim_customer" = Table.ExpandTableColumn(#"Merged Queries", "dim_customer", {"customer_id"}, {"dim_customer.customer_id"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Expanded dim_customer",{"dim_customer.customer_id", "OrderID", "CustomerName", "OrderDate"}),
    #"Removed Columns" = Table.RemoveColumns(#"Reordered Columns",{"CustomerName"}),
    #"Reordered Columns1" = Table.ReorderColumns(#"Removed Columns",{"OrderID", "dim_customer.customer_id", "OrderDate"}),
    #"Merged Queries1" = Table.NestedJoin(#"Reordered Columns1", {"OrderID"}, shipments, {"OrderID"}, "shipments", JoinKind.LeftOuter),
    #"Expanded shipments" = Table.ExpandTableColumn(#"Merged Queries1", "shipments", {"ShipDate", "DeliveryDate"}, {"ShipDate", "DeliveryDate"}),
    #"Merged Queries2" = Table.NestedJoin(#"Expanded shipments", {"OrderID"}, INVOICES, {"OrderID"}, "INVOICES", JoinKind.LeftOuter),
    #"Expanded INVOICES1" = Table.ExpandTableColumn(#"Merged Queries2", "INVOICES", {"InvoiceID", "InvoiceDate"}, {"InvoiceID", "InvoiceDate"}),
    #"Merged Queries3" = Table.NestedJoin(#"Expanded INVOICES1", {"InvoiceID"}, payments, {"InvoiceID"}, "payments", JoinKind.LeftOuter),
    #"Expanded payments" = Table.ExpandTableColumn(#"Merged Queries3", "payments", {"PayDate"}, {"PayDate"}),
    #"Removed Columns1" = Table.RemoveColumns(#"Expanded payments",{"InvoiceID"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns1",{{"PayDate", "pay_date"}, {"InvoiceDate", "invoice_date"}, {"DeliveryDate", "delivery_date"}, {"ShipDate", "ship_date"}, {"OrderDate", "order_date"}, {"OrderID", "order_id"}, {"dim_customer.customer_id", "customer_id"}})
in
    #"Renamed Columns"

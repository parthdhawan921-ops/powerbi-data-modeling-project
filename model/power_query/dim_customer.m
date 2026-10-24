let
    Source = CUST_MASTER,
    #"Filtered Rows" = Table.SelectRows(Source, each ([CustomerID] <> 9999)),
    #"Merged Queries" = Table.NestedJoin(#"Filtered Rows", {"CustomerID"}, customer_contacts, {"CustomerID"}, "customer_contacts", JoinKind.LeftOuter),
    #"Expanded customer_contacts" = Table.ExpandTableColumn(#"Merged Queries", "customer_contacts", {"ContactName", "Email", "IsPrimary"}, {"ContactName", "Email", "IsPrimary"}),
    #"Merged Queries1" = Table.NestedJoin(#"Expanded customer_contacts", {"CustomerID"}, user_details, {"UserID"}, "user_details", JoinKind.LeftOuter),
    #"Expanded user_details" = Table.ExpandTableColumn(#"Merged Queries1", "user_details", {"CreditLimit", "Phone"}, {"CreditLimit", "Phone"}),
    #"Merged Queries2" = Table.NestedJoin(#"Expanded user_details", {"AddressID"}, Address, {"AddressID"}, "Address", JoinKind.LeftOuter),
    #"Expanded Address" = Table.ExpandTableColumn(#"Merged Queries2", "Address", {"Street", "CityName"}, {"Street", "CityName"}),
    #"Merged Queries3" = Table.NestedJoin(#"Expanded Address", {"CityName"}, cities, {"CityName"}, "cities", JoinKind.LeftOuter),
    #"Expanded cities" = Table.ExpandTableColumn(#"Merged Queries3", "cities", {"RegionName"}, {"RegionName"}),
    #"Removed Columns" = Table.RemoveColumns(#"Expanded cities",{"AddressID", "hash_key", "source_id", "IsPrimary"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"CustomerID", "customer_id"}, {"CustomerName", "customer_name"}, {"Segment", "segment"}, {"AccountManager", "account_manager"}, {"PaymentTerms", "payment_terms"}, {"ContactName", "contact_name"}, {"Email", "email"}, {"CreditLimit", "credit_limit"}, {"Phone", "phone"}, {"Street", "street"}, {"CityName", "city_name"}, {"RegionName", "region_name"}})
in
    #"Renamed Columns"

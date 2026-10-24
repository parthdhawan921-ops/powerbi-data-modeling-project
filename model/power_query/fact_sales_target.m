let
    Source = sales_targets,
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Period", "date"}, {"TargetRevenue", "target_revenue"}})
in
    #"Renamed Columns"

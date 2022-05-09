$where_excel = "D:\Audit_PC"
$result = @()

$exel_file = @((Get-ChildItem -path $where_excel).Name)
for ($i=0;$i -lt $exel_file.Count;$i++){
    $child_excel = $exel_file[$i]
    $value_excel = Import-Csv -Path "${where_excel}\$child_excel"
    $result += $value_excel
}

$result | Export-Csv -path "${where_excel}\final.csv" -NoTypeInformation

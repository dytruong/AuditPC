# Input username
$username = read-host "Your name";
$username = $username.Replace(' ','')
$username = $username.ToLower()

# Function get specification
function specs {
    param($user)
    $cpu = (Get-CimInstance -ClassName CIM_Processor).Name;
    $ram = ((Get-ComputerInfo).OsTotalVisibleMemorySize)/0.001Gb;
    $rounding_ram = ([math]::Truncate($ram))+1;
    $ram_info = "${rounding_ram}Gb";
    $GPU = (Get-WmiObject win32_VideoController).Description

    # Get physical disk
    $pdisk_size_1 = @((Get-PhysicalDisk).size)
    $pdisk_type = @((Get-PhysicalDisk).MediaType)

    for ($i = 0; $i -lt $pdisk_type.Count; $i++){
        $pd_type = $pdisk_type[$i]
        $pd_size = $pdisk_size_1[$i]
        $rounding_size = [math]::round($pd_size/1Gb,2)
        $pdisk_info += "{0}-{1}Gb;" -f $pd_type,$rounding_size
    }
    write-host "----------------------------"
    $details = @{
        "Username" = $user
        "cpu" = $cpu
        "ram" = $ram_info
        "GPU" = $GPU 
        "HDD" = $pdisk_info
    }
    $result = New-Object psobject -Property $details

    $D = (Get-Partition).DriveLetter
    foreach ($p_D in $D){
        if ($p_D -eq "D"){
            $location = "$p_D"
        }else{
            $location = "C";}
    }
    $result | Export-Csv -Path "${location}:\$user.csv" -NoTypeInformation
    Invoke-Item "${location}:\"
}

specs -user $username
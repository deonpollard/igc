 # +------------------------------------------------------------------------------------------+
# | Author...........: Deon Pollard.  Deon Pollard & Associates                               |
# | Date.............: 05 Dec 2018                                                            |
# | Description......: Script to call IGC Rest service MUST use PS 6.0 or later               |
# | Parameters.......: $OPath Path and filename of output CSV that contains Output            |
# +-------------------------------------------------------------------------------------------+
$OPath = "c:/tmp/csv6.csv"
 function Get-BasicAuthCreds {
    param([string]$Username,[string]$Password)
    $AuthString = "{0}:{1}" -f $Username,$Password
    $AuthBytes  = [System.Text.Encoding]::Ascii.GetBytes($AuthString)
    return [Convert]::ToBase64String($AuthBytes)
}
$BasicCreds = Get-BasicAuthCreds -Username "isadmin" -Password "isadmin"
$myurl = "https://localhost:9443/ibm/iis/igc-rest/v1/types/"
$PSVersionTable.PSVersion
# Output Json Response as is
# | Out-File -FilePath "c:/tmp/ycsv1.json" 
$Output = Invoke-restmethod -Uri $myurl -SkipCertificateCheck -Headers @{"Authorization"="Basic $BasicCreds"}
$Output | Select-Object _id, _name, _plural, _url | Export-CSV $OPath -NoTypeInformation
write-host "Rest API IGC, " $Output.Count  " Types"
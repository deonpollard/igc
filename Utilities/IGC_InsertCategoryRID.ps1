# +------------------------------------------------------------------------------------------+
# | Author...........: Deon Pollard.  Deon Pollard & Associates                              |
# | Date.............: 08 Dec 2018                                                           |
# | Description......: Script to call IGC Rest service, MUST use PS 6.0 or later             |
# | .................: Insert Categories, Ipath file contains csv with list of categories    |  
# | Parameters.......: $IPath Path and filename of output CSV that contains Input            |
# +------------------------------------------------------------------------------------------+
#
#
 function Get-BasicAuthCreds {
    param([string]$Username,[string]$Password)
    $AuthString = "{0}:{1}" -f $Username,$Password
    $AuthBytes  = [System.Text.Encoding]::Ascii.GetBytes($AuthString)
    return [Convert]::ToBase64String($AuthBytes)
}
$IPath = "c:/tmp/categories.csv"
$BasicCreds = Get-BasicAuthCreds -Username "isadmin" -Password "isadmin"
$myurl = "https://localhost:9443/ibm/iis/igc-rest/v1/assets"
$myurlRID = "https://localhost:9443/ibm/iis/igc-rest/v1/search/?types=category&search-properties=name&text="
$cats = Import-Csv $IPath
Foreach ($cat in $cats) {
    write-host $cat.name, $cat.parent_category
    if ($cat.parent_category.length -gt 0) { 
            $nameURL = -join($myurlRID, $cat.parent_category)
            $Output = Invoke-restmethod -Uri $nameURL -SkipCertificateCheck -Headers @{"Authorization"="Basic $BasicCreds"}
            #$P = $Output | Format-Table -Property Paging
            if ($Output.Paging.numtotal -eq 0) {
               write-host $cat.parent_category "  - Parent_Category not found for " $cat.name
               continue
              } else {
               $RID = $Output.items._id
              }
            #
              $rawjson = @{ _type = "category"
                    name = $cat.name
                    short_description = $cat.short_description
                    parent_category = $RID
                    }

        } else {  # parent_category is empty pointing to root
             $rawjson = @{ _type = "category"
                name = $cat.name
                short_description = $cat.short_description
                }


    }
    $JSON = $rawjson | ConvertTo-Json
    try {
    $Output = Invoke-restmethod -Uri $myurl -SkipCertificateCheck -Headers @{"Authorization"="Basic $BasicCreds"} -Method Post -Body $JSON -ContentType "application/json"
    write-host "INSERTED - > " $cat.name, $cat.parent_category 
    } catch {
        # Dig into the exception to get the Response details.
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
    }
 } # foreach
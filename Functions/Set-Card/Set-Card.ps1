function Set-Card {
    <#
      .Synopsis 
       Sets a Trello Card with provided values.
      .Description 
       Sets a Trello Card with provided values.
    #>
    [cmdletbinding()]
    param (
        [parameter(
            Mandatory=$true,
            Position=0
        )]
        $Token,
        [parameter(
            Mandatory=$true,
            Position=1
        )]
        $CardId,
        [parameter(
            Mandatory=$false,
            Position=2
        )]
        $Name,
        [parameter(
            Mandatory=$false,
            Position=3
        )]
        $Description
    )
    begin
    {
    }
    process
    {
        try {
            if($Name) { 
                [hashtable]$Hash = @{
                    value = $Name 
                }
                $Data = $Hash | ConvertTo-Json
                Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$CardId/name/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Data -ContentType "application/json"
            }
            if($Description) { 
                [hashtable]$Hash = @{
                    value = $Description 
                }
                $Data = $Hash | ConvertTo-Json
                Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$CardId/desc/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Data -ContentType "application/json"
            }
        }
        catch
        {
            Write-Error $_
        }
    }
    end
    {
    }
}

Export-ModuleMember Set-Card
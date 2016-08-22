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
        $Card,
        [parameter(
            Mandatory=$false,
            Position=2
        )]
        $Name,
        [parameter(
            Mandatory=$false,
            Position=3
        )]
        $Description,
        [parameter(
            Mandatory=$false,
            Position=4
        )]
        $List,
        [parameter(
            Mandatory=$false,
            Position=5
        )]
        [switch]$Archive
    )
    begin
    {
    }
    process
    {
        try {
            # Check if the whole card data was passed in, assume attribute is Id
            if($Card -is "PSCustomObject") {
                $CardId = $Card.Id
            } else {
                $CardId = $Card
            }
            
            # If the Name parameter was filled in then PUT the new value
            if($Name) { 
                $Hash = @{ value = $Name } | ConvertTo-Json
                Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$CardId/name/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash -ContentType "application/json"
            }

            # If the Description parameter was filled in then PUT the new value
            if($Description) { 
                $Hash = @{ value = $Description } | ConvertTo-Json
                Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$CardId/desc/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash -ContentType "application/json"
            }

            # Check if the whole list data was passed in, assume attribute is Id, PUT the new value
            if($List) {
                if($List -is "PSCustomObject") {
                    $Value = $List.Id
                } else {
                    $Value = $List
                }
                $Hash = @{ value = $Value } | ConvertTo-Json
                Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$CardId/idList/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash -ContentType "application/json"
            }

            # If the Archive parameter was selected then PUT the true statement
            if($Archive) { 
                $Hash = @{ value = $true } | ConvertTo-Json
                Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$CardId/closed/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash -ContentType "application/json"
            }
        }
        catch
        {
            throw $_
        }
    }
    end
    {
    }
}

Export-ModuleMember Set-Card
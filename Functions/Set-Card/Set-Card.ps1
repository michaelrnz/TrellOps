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
            if($Name) { 
                $Hash = @{ value = $Name } | ConvertTo-Json
                Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$($Card.Id)/name/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash -ContentType "application/json"
            }
            if($Description) { 
                $Hash = @{ value = $Description } | ConvertTo-Json
                Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$($Card.Id)/desc/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash -ContentType "application/json"
            }
            if($List) { 
                $Hash = @{ value = $List.Id } | ConvertTo-Json
                Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$($Card.Id)/idList/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash -ContentType "application/json"
            }
            if($Archive) { 
                $Hash = @{ value = $true } | ConvertTo-Json
                Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$($Card.Id)/closed/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash -ContentType "application/json"
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
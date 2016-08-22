function Move-Card {
    <#
      .Synopsis 
       Moves a Trello Card between lists.
      .Description 
       Moves a Trello Card between lists.
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
            Mandatory=$true,
            Position=2
        )]
        $TargetListId
    )
    begin
    {
    }
    process
    {
        [hashtable]$Hash = @{
            value = $TargetListId
        }
		$Data = $Hash | ConvertTo-Json
        try {
            Invoke-RestMethod -Method Put -Uri "https://api.trello.com/1/cards/$CardId/idList?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Data -ContentType "application/json"
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

Export-ModuleMember Move-Card
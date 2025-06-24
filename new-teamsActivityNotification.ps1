function new-teamsActivityNotification  {
    <#
    .DESCRIPTION 
    Function to send activity notifications in teams with application permissions through a dummy teams app

    .EXAMPLE 
    new-teamsActivityNotification -recipient "john.doe@contoso.com" -teamsAppId "e415c669-b20e-424d-806e-f2c84089004t" -message "WhOOOP WhoOoOP 🎉"

    .NOTES
    Install and authenticate the "powershell.graph" module before executing this function. 
    When using application permissions, the permission "TeamsActivity.Send.User" is required

    #>
    param (
        [Parameter(Mandatory = $true)]
        [String]$message,

        [Parameter(Mandatory = $true)]
        [String]$recipient,

        [Parameter(Mandatory = $true)]
        [String]$teamsAppId
    )

    # encoded notification message
    $contextJson = @{ subEntityId = $message } | ConvertTo-Json -Compress
    $encodedContext = [System.Web.HttpUtility]::UrlEncode($contextJson)

    # Construct webUrl
    $entityId = "main"
    $webUrl = "https://teams.microsoft.com/l/entity/$teamsAppId/$entityId`?context=$encodedContext"

    # Notification body
    $body = @{
        topic = @{
            source = "text"
            value = "New message from Notify app"
            webUrl = $webUrl
        }
        activityType = "customNotification"
        previewText = @{
            content = "Info"
        }
        templateParameters = @(
            @{
                name  = "text"
                value = $message
            }
        )
    } | ConvertTo-Json -Depth 10

    # Send the request
    $uri = "https://graph.microsoft.com/v1.0/users/$recipient/teamwork/sendActivityNotification"
    Invoke-GraphRequest -Method POST -Uri $uri -Body $body
}

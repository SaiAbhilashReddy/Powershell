#User Detail 

$api_key = 'lh3t83w37bgtx641'  
$api_secret = '62dflsacw5f8cozbmetg7n0wi0s32cgs'  

#request_token_link=https://kite.zerodha.com/?action=login&status=success&request_token=KXvEiOAuuiV1Q78O1nH3DHrUSmsWqMS1

$ready = Read-Host -Prompt 'Enter any key to continue'
$request_token = Read-Host -Prompt 'Please enter your request token'
#request_token=KXvEiOAuuiV1Q78O1nH3DHrUSmsWqMS1

Function Get-StringHash([String] $String,$HashName = "MD5") 

{ $StringBuilder = New-Object System.Text.StringBuilder 
[System.Security.Cryptography.HashAlgorithm]::Create($HashName).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($String))|%{ 
[Void]$StringBuilder.Append($_.ToString("x2")) } 

$StringBuilder.ToString()}

$sha256string = Get-StringHash "$api_key$request_token$api_secret" "SHA256"

$basic_header = @{ 'X-Kite-Version' = '3'}

$auth = @{ 'api_key'=$api_key ; 'request_token'=$request_token ; 'checksum'=$sha256string}

try { $token = (Invoke-RestMethod "https://api.kite.trade/session/token" -Method Post -Headers $basic_header -Body $auth).data
$access_token = $token.access_token
Write-Host "Successfully logged in to Zerodha account." -ForegroundColor Green }
catch {Write-Host "Could not login to Zerodha account please re-run the script." -BackgroundColor Yellow -ForegroundColor Red}
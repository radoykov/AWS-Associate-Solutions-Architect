<powershell>
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to My Website</title>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>This is a custom HTML page served from my IIS server on EC2.</p>
</body>
</html>
"@

$htmlPath = "C:\inetpub\wwwroot\index.html"
Set-Content -Path $htmlPath -Value $htmlContent

Start-Service -Name W3SVC
Set-Service -Name W3SVC -StartupType Automatic
Restart-Service -Name W3SVC
</powershell>

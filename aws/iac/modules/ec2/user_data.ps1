# Preferências Gerais
$ErrorActionPreference = 'Stop';
$ProgressPreference = 'SilentlyContinue';

# Ajustando Timezone para Sao Paulo
Write-Host("Adjusting Time Zone...")
Set-Timezone -Id "E. South America Standard Time"

# Ajuste de linguagem no System Locale para non-Unicode Programs
Set-WinSystemLocale -SystemLocale pt-BR

# Desativando o Firewall do Windows
Write-Host("Disabling Windows Firewall...")
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False

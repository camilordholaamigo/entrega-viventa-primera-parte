# Instala en Claude Code las skills de Viventa.
# Uso:  powershell -ExecutionPolicy Bypass -File .\instalar.ps1                    -> las 28
#       powershell -ExecutionPolicy Bypass -File .\instalar.ps1 lizeth-henriquez   -> solo las de esa persona
param([string]$Persona = "")
$ErrorActionPreference = "Stop"
$raiz = Split-Path -Parent $MyInvocation.MyCommand.Path
$destino = Join-Path $HOME ".claude\skills"
if ($Persona) {
  $lista = Join-Path $raiz "personas\$Persona.skills"
  if (-not (Test-Path $lista)) {
    $opciones = (Get-ChildItem (Join-Path $raiz "personas") -Filter *.skills | ForEach-Object { $_.BaseName }) -join " "
    Write-Error "No conozco a '$Persona'. Opciones: $opciones"
  }
  $skills = Get-Content $lista | Where-Object { $_ -and -not $_.StartsWith("#") }
} else {
  $skills = Get-ChildItem (Join-Path $raiz "skills") -Directory | ForEach-Object { $_.Name }
}
New-Item -ItemType Directory -Force -Path $destino | Out-Null
$n = 0
foreach ($s in $skills) {
  $d = Join-Path $destino $s
  New-Item -ItemType Directory -Force -Path $d | Out-Null
  Copy-Item -Recurse -Force (Join-Path $raiz "skills\$s\*") $d
  $n++
}
Write-Host "Listo: $n skills instaladas en $destino. Reinicia Claude Code para que las cargue."

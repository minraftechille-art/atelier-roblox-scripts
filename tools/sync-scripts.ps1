# Génère les fichiers .lua du dossier scripts/ à partir de scripts.json
# scripts.json reste la source de vérité (l'app Canva "Atelier Roblox" le lit).
# Usage : powershell -File tools/sync-scripts.ps1

$root = Split-Path -Parent $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)
$json = [IO.File]::ReadAllText((Join-Path $root "scripts.json"), $utf8) | ConvertFrom-Json

$folders = @{ "Gameplay" = "gameplay"; "Interface" = "interface"; "Systèmes" = "systemes"; "Outils" = "outils" }
$scriptsDir = Join-Path $root "scripts"
# on ne supprime que les .lua générés : les README et .gitkeep des dossiers restent
if (Test-Path $scriptsDir) { Get-ChildItem $scriptsDir -Recurse -Filter *.lua | Remove-Item -Force }

foreach ($s in $json.scripts) {
    $sub = $folders[$s.category]
    if (-not $sub) { $sub = "autres" }
    $dir = Join-Path $scriptsDir $sub
    New-Item -ItemType Directory -Force $dir | Out-Null
    $header = @(
        "--[[",
        "  $($s.name)",
        "  $($s.description)",
        "",
        "  Emplacement : $($s.location)",
        "  Statut      : $($s.status)  |  Auteur : $($s.author)  |  Date : $($s.date)",
        "  (Fichier généré depuis scripts.json - modifier scripts.json puis relancer tools/sync-scripts.ps1)",
        "]]",
        ""
    ) -join "`n"
    $code = $s.code -replace "`r`n", "`n"
    [IO.File]::WriteAllText((Join-Path $dir "$($s.id).lua"), $header + $code, $utf8)
    Write-Output "scripts/$sub/$($s.id).lua"
}

$OutputEncoding = [System.Console]::OutputEncoding = [System.Console]::InputEncoding = [System.Text.Encoding]::UTF8
oh-my-posh init pwsh --config "C:\Program Files (x86)\oh-my-posh\themes\dracula.omp.json" | Invoke-Expression
$Env:KOMOREBI_CONFIG_HOME = "$env:USERPROFILE\.config\komorebi"
function Logger {
    $lastCommand = (Get-History -Count 1).CommandLine
    $timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ss"
    "$timestamp $lastCommand" | Out-File -Append -FilePath "$PWD\cli.log"
}

function prompt {
    Logger
    return "PS $PWD> "
}

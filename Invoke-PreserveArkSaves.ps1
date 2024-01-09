Write-Host "Hello World";

$path_to_exe = ".\ShooterGame\Binaries\Win64\ArkAscended.exe"
$backup_limit = 50;

$exe = Get-ChildItem $path_to_exe -File

Get-EventSubscriber -SourceIdentifier "ArkSaves" -ErrorAction Ignore | Unregister-Event

$local_arks = Get-ChildItem '.\ShooterGame\Saved\SavedArksLocal' -Directory
$local_arks | ForEach-Object {
    $dir = $_.FullName
    $save_name = $_.Name
    $save_file = Get-ChildItem "$($dir)\$($save_name).ark"

    write-host $save_file.FullName
    
    $message_data = new-object psobject -property @{
        backup_limit = $backup_limit;
        dir          = $dir;
        save_file    = $save_file;
    }

    $Watcher = New-Object IO.FileSystemWatcher $dir, $save_file.Name -Property @{ 
        IncludeSubdirectories = $false
        NotifyFilter          = [IO.NotifyFilters]'FileName, LastWrite'
    }

    Register-ObjectEvent $Watcher `
        -EventName Changed `
        -SourceIdentifier "ArkSaves" `
        -MessageData $message_data `
        -Action {

        $dir = $Event.MessageData.dir;
        $dir_info = Get-Item $dir;
        $save_file = $Event.MessageData.save_file;
        $save_name = $dir_info.Name;
        $backup_limit = $Event.MessageData.backup_limit;

        $date_str = Get-Date -Format "yyyy-MM-dd-hh-mm-ss"
        $backup_filename = "$($dir)\$($save_name).ArkSaves.$($date_str).ark.bak"

        # First let's create a backup of the save file.
        write-host "Copying $($save_file.FullName) to $backup_filename"
        Copy-Item -Path $save_file.FullName -Destination $backup_filename

        # Now let's remove older save files in order to preserve storage space.
        $saves = Get-ChildItem -Path $ark.FullName -filter "*ArkSaves*.ark.bak" | Sort-Object { $_.LastWriteTime } -Descending
        if ($saves.Count -gt $backup_limit) {
            $oldest_backup = $saves | Select-Object -Last 1
            write-host "Backup limit exceeded. Deleting oldest backup: $($oldest_backup.Name).";
            Remove-Item $oldest_backup.FullName;
        }

    }
}

$handles | Out-Host

Start-Process $exe.FullName
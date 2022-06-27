# Opens Dialog box with select functioning and will parse entire folder.
    function Read-OpenFileDialog([string]$WindowTitle, [string]$InitialDirectory) {
            Add-Type -AssemblyName System.Windows.Forms
            $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
            $openFileDialog.Title = $WindowTitle
            if (![string]::IsNullOrWhiteSpace($InitialDirectory)) { $openFileDialog.InitialDirectory = $InitialDirectory }
            $openFileDialog.Filter = $Filter
            if ($AllowMultiSelect) { $openFileDialog.MultiSelect = $true }
            $openFileDialog.ShowHelp = $true
            $openFileDialog.ShowDialog() > $null
            if ($AllowMultiSelect) { return $openFileDialog.Filenames } else { return $openFileDialog.Filename }
        }
        #stores FileName as Variable.
        $FileName = (Read-OpenFileDialog)
        #Splits path from FileName
        $FileRoot = Split-Path -Parent $FileName
        $File1 = Split-Path -Leaf $FileName
        #Splits for extensions and selects the beginning part or the first index located.
        $File = ($File1).Split(".")[0]
        #Grabs all the files from the split path and send them using * to the $allofThem Variable
        $AllofThem = Split-Path -path "$FileRoot/$File.*" -Resolve -Leaf


        $allFiles = @($FileRoot)+$AllofThem
        #File combination names getting saved to the $filescombination variable and saved as $allfiles
        foreach ($name in $AllofThem){
            $filesCombination = $FileRoot+$name
            }


         Compress-Archive -LiteralPath $FileRoot/$AllofThem -DestinationPath $FileRoot

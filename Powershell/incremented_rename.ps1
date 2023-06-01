# This is a script to help manage show files after dumping disks
# basically in a Season Directory we might have inconsistent filenames
# this script takes as input a basename i.e "S01".
# then this sorts all the files in the directory by time modified (assuming that the write time is consistent with the actual episode order)
# then the files in the directory are renamed something like "S01-E01", "S01-E02", and so on...

# need to input a basename for the renaming and an increment for the renaming
# for example if the increment is 1, then renaming will start like S00E02,then S00E03, and so on
# if increment is 0, then the renaming will be like S00E01, then S00E02, and so on
param ([string]$basename, [int]$increment=0)

# retrieving files in the directory this script is called in
$FileList = Get-ChildItem -Attributes !Directory -Path $PWD

# sorting the files by last modified time (first item is the earliest modified)
$FileList = Sort-Object -Property LastWriteTime -InputObject $FileList

# renaming files like "S01E01", "S01E02" and so on
for ($i=0; $i -lt $FileList.Count ; $i++){
    $file = $FileList[$i]
    $renamed = $basename + "E{0:D2}" -f ($i + $increment + 1) + $file.Extension
    Rename-Item -Path $file.FullName -NewName $renamed 
    Write-Host $renamed ::: $file.LastWriteTime
}

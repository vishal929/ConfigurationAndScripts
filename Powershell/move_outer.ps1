# this script will move nested files x levels deep up to the root folder (where this script is called)

# the default depth is 1
param($depth=1)

# get the files we want to move to root
$files = Get-ChildItem -Attributes !Directory -Depth $depth -Path $PWD

# move the files to root
for ($i=0; $i -lt $files.Count; $i++){
    $file = $files[$i];
    Move-Item -Path $file.FullName -Destination $PWD
    Write-Host "Moved " $file.BaseName
}





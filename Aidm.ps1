# Script for standard procedures of editing image with Aidm
# This script is called with path to an input image
param(
    [string]$image_path
)

Write-Host @"
          _     _           
    /\   (_)   | |          
   /  \   _  __| |_ __ ___  
  / /\ \ | |/ _` | '_ ` _ \ 
 / ____ \| | (_| | | | | | |
/_/    \_\_|\__,_|_| |_| |_|
                            
 An AI ID Manipulation tool
       by Luk Cogito 
"@

# Define the path to the splash screen executable
$splash_path = ".\splash\splash.exe"

# Start the splash screen
Start-Process -FilePath $splash_path -ArgumentList "/b"

# Get the directory where the file is located 
$directory = [System.IO.Path]::GetDirectoryName($image_path)

# Extract the file name without extension
$file_name = [System.IO.Path]::GetFileNameWithoutExtension($image_path)
 
# Replace possible " " in file name with "_"
$file_name = $file_name -replace ' ', '_'

# Define a directory with the same name (possibly edited) as the file
$working_directory = Join-Path -Path $directory -ChildPath $file_name

# Create the directory
New-Item -Path $working_directory -ItemType Directory
 
# Define a path for img edit
$img_edit_path = Join-Path -Path $working_directory -ChildPath "$file_name.png" 

# Define a command for image conversion and copy
$command = "ffmpeg -i `"$image_path`" `"$img_edit_path`" -loglevel quiet"

# Execute the command with invoke expression
Invoke-Expression $command
 
#________________________________________________________________________ 
# Here starts the part of this script for cropping and aligning the image

# Add the system drawing module
Add-Type -AssemblyName System.Drawing

# Load the image for editing
$image = [System.Drawing.Image]::FromFile($img_edit_path)

# Get the width and height of the image
$width = $image.Width
$height = $image.Height

# Calculate dimensions based on a ratio of 265:310
$ratio = 265 / 310
$min_diff = [double]::MaxValue
$result = 0, 0

for ($x = 1; $x -le $width; $x++) {
    # Truncate the division result to get an integer value for y
    $y = [Math]::Truncate($x / $ratio)
    if ($y -gt $height) {
        break
    }
    # Calculate the difference between (width - height) and (x - y)
    $diff = [Math]::Abs(($width - $height) - ($x - $y))
    if ($diff -lt $min_diff) {
        # If this difference is smaller than min_diff, update min_diff and result
        $min_diff = $diff
        $result = $x, $y
    }
}

$new_width, $new_height = $result

# Extract the directory, filename, and extension
$directory = [System.IO.Path]::GetDirectoryName($img_edit_path)
$filename = [System.IO.Path]::GetFileNameWithoutExtension($img_edit_path)
$extension = [System.IO.Path]::GetExtension($img_edit_path)

# Define an output path
$output_path = [System.IO.Path]::Combine($directory, $filename + "_cropped" + $extension)

# Add new dimensions to photoidmagick command
$command = "photoidmagick.exe -f `"$img_edit_path`" -s ${new_width}x${new_height} --allow-oblique-face --allow-unevenly-open-eye --allow-open-mouth --allow-abnormally-open-eyelid --allow-unevenly-open-eye"

# Echoing a message for the user.
echo "Cropping the image."

# Execute the photoidmagick command with Invoke-Expression
Invoke-Expression $command

# Get the last edited file in the directory
$output_wrong_format = Get-ChildItem -Path $working_directory -Recurse | Sort-Object LastWriteTime -Descending | Select-Object -First 1

# Store the full path of the file in a variable
$output_wrong_format_path = $output_wrong_format.FullName

# Define a command for image conversion and copy
$command = "ffmpeg -i `"$output_wrong_format_path`" `"$output_path`" -loglevel quiet"

# Execute the command with invoke expression
Invoke-Expression $command

# Relax boi
Start-Sleep -Seconds 2

# Remove the item in wrong format
Remove-Item -Path $output_wrong_format_path

#___________________________________________________________________________
# Here starts the part of this script for adjusting a color and a brightness

# Set the output path as a path for editing
$img_edit_path = $output_path

# Define a new filename
$filename = [System.IO.Path]::GetFileNameWithoutExtension($img_edit_path)

# Define an actual file extension
$extension = [System.IO.Path]::GetExtension($img_edit_path)

# Define an output path
$output_path = [System.IO.Path]::Combine($directory, $filename + "_adjusted" + $extension)

# Define a command for adjusting color and brightness
$command = "pythonw `".\standard_procedure\color_and_brightnes_adjust.py`" `"$img_edit_path`" `"$output_path`""

# Echoing a message for the user.
echo "Adjusting a color and a brightness of the image."

# Execute the command with Invoke-Expression
Invoke-Expression $command

#______________________________________________________________
# Here starts the part of this script for removing a background

# Set the output path as a path for editing

$img_edit_path = $output_path

# Define a new filename
$filename = [System.IO.Path]::GetFileNameWithoutExtension($img_edit_path)

# Define an output path
$output_path = [System.IO.Path]::Combine($directory, $filename + "_transparent" + $extension)

# Define a command for the background removal
$command = "backgroundremover.exe -i `"$img_edit_path`" -m `"u2net_human_seg`" -o `"$output_path`""

# Echoing a message for the user.
echo "Remove a background of the image."

# Execute the command with Invoke-Expression
Invoke-Expression $command

#________________________________________________________________
# Here starts the part of this script for adding a new background

# Set the output path as a path for editing
$img_edit_path = $output_path

# Define a new filename
$filename = [System.IO.Path]::GetFileNameWithoutExtension($img_edit_path)

# Define an output path
$output_path = [System.IO.Path]::Combine($directory, $filename + "_background" + $extension)

# Define a command for adding a new background
$command = "pythonw `".\standard_procedure\add_background.py`" `"$img_edit_path`" `"$output_path`""

# Echoing a message for the user.
echo "Adding a new background to the image."

# Execute the command with Invoke-Expression
Invoke-Expression $command

#____________________________
# Final conversion and export

# Set extension to jpg (because desired output is)
$extension = ".jpg"

# Define the final path (in parent directory of working directory)
$parent_directory = [System.IO.Directory]::GetParent($directory).FullName
$final_path = [System.IO.Path]::Combine($parent_directory, $filename + "_background" + $extension)

# Define a command for image conversion and copy
$command = "ffmpeg -i `"$output_path`" `"$final_path`" -loglevel quiet"

# Echoing a message for the user.
echo "Here you go! The process is now complete."

# Relax for three secs
Start-Sleep -Seconds 3

# Execute the command with Invoke-Expression
Invoke-Expression $command

# Stop the splash screen
Stop-Process -Name "splash"

exit 0
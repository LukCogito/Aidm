# Script for bluring an image

# This script is called with path to an input image
param (
    [string]$image_path
)

# Extract the file name without extension
$file_name = [System.IO.Path]::GetFileNameWithoutExtension($image_path)

# Replace possible " " in file name with "_"
$file_name = $file_name -replace ' ', '_'

# Extract the directory, filename, and extension
$directory = [System.IO.Path]::GetDirectoryName($image_path)
$extension = [System.IO.Path]::GetExtension($image_path)

# Define an input path with edited filename

# Define an output path
$output_path = [System.IO.Path]::Combine($directory, $file_name + "_cropped" + $extension)

# Add new dimensions to photoidmagick command
$command = "C:\AIM\additional_procedure\py\blur.py "

# Execute the photoidmagick command with Invoke-Expression
Invoke-Expression $command
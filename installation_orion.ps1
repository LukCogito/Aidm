# Installation script for dependencies of Aidm

echo "Installing Python..."

# Set an URL for downloading Python
$python_url = "https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe"

# Set a path for downloading Python
$installer = "$env:TEMP\python-3.11.8-amd64.exe"

# Download Python installer
Invoke-WebRequest -Uri $python_url -OutFile $installer

# Install Python silently
$installer /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

# Remove the installer
Remove-Item $installer


echo "Installing pip..."

# Check if the version of pip is up to date and install lastest if not
py -m pip install --upgrade pip


echo "Installing cmake..."

# Set an URL for downloading cmake
$cmake_url = "https://github.com/Kitware/CMake/releases/download/v3.29.0-rc3/cmake-3.29.0-rc3-windows-x86_64.msi"

# Set a path for downloading cmake
$installer = "$env:TEMP\cmake-3.29.0-rc3-windows-x86_64.msi"

# Download cmake installer
Invoke-WebRequest -Uri $cmake_url -OutFile $installer

# Install cmake silently
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $installer /qn /norestart" -Wait

# Remove the installer
Remove-Item $installer


echo "Defining paths..."

# Get the current value of the PATH environment variable
$Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

# Define the path to the 7-Zip directory
$7Zip_path = "C:\Program Files\7-Zip\"

# Verify if path to 7zip exists
if(-not (Test-Path -Path $7Zip_path)){
    # Define the download URL and installer location
    $7zip_url = "https://www.7-zip.org/a/7z2401-x64.msi"
    $installer = "$env:TEMP\7z2401-x64.msi"
    
    # Download 7-Zip installer
    Invoke-WebRequest -Uri $7zip_url -OutFile $installer
    
    # Install 7-Zip silently
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $installer /qn" -Wait
    
    # Remove the installer
    Remove-Item $installer
}


# Define the path to the cmake directory
$cmakePath = "C:\Program Files\CMake\bin\"

# Check if the 7-Zip path is already in the PATH environment variable
if (-not ($Path).Contains($7ZipPath)) {
    # If not, add the 7-Zip path to the PATH environment variable
    [System.Environment]::SetEnvironmentVariable("Path", $Path + ";" + $7ZipPath, "Machine")
}

# Set an alias for 7-Zip
Set-Alias 7zip "C:\Program Files\7-Zip\7z.exe"

# Check if the cmake path is already in the PATH environment variable
if (-not ($Path).Contains($cmakePath)) {
    # If not, add the cmake path to the PATH environment variable
    [System.Environment]::SetEnvironmentVariable("Path", $Path + ";" + $cmakePath, "Machine")
}

# Get the current environment variables from the Machine and User scopes
$MachinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
$UserPath = [System.Environment]::GetEnvironmentVariable("Path", "User")

# Combine the Machine and User paths, and update the current session's Path environment variable
$Env:Path = $MachinePath + ";" + $UserPath


echo "Installing ffmpeg..."

# Install ffmpeg (free and open-source software project consisting of a suite of libraries and programs for handling video, audio, and other multimedia files and streams)
# Set an URL for downloading ffmpeg
$ffmpeg_url = "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full.7z"

# Set a path for downloading ffmpeg
$zip_file = "$env:TEMP\ffmpeg-release-full.7z"

# Set a path for extracting ffmpeg
$ffmpeg_extraction_path = "C:\Program Files\ffmpeg-6.1.1-full_build"

# Download ffmpeg zip file
Invoke-WebRequest -Uri $ffmpeg_url -OutFile $zip_file

# Extract ffmpeg silently
7zip x $zip_file $ffmpeg_extraction_path

# Remove the zip file
Remove-Item $zip_file


echo "Installing VS Build Tools for C++ ..."

# Install Visual Studio Build Tools for C++
# Source: https://visualstudio.microsoft.com/cs/visual-cpp-build-tools/

# Set an URL for downloading vs
$vs_url = "https://aka.ms/vs/17/release/vs_BuildTools.exe"

# Set a path for downloading vs
$installer = "$env:TEMP\vs_BuildTools.exe"

# Download vs installer
Invoke-WebRequest -Uri $vs_url -OutFile $installer

# Install vs silently
Start-Process $installer -ArgumentList '--quiet', '--wait', '--norestart', '--nocache', '--installPath C:\BuildTools', '--add Microsoft.VisualStudio.Workload.VCTools', '--add Microsoft.VisualStudio.Component.VC.Tools.x86.x64', '--add Microsoft.VisualStudio.Component.VC.ATL', '--add Microsoft.VisualStudio.Component.VC.CLI.Support', '--add Microsoft.VisualStudio.Component.Windows10SDK.18362' -NoNewWindow -Wait

# Remove the installer
Remove-Item $installer


echo "Installing essential Python packages via pip..."

# Install PyTorch
pip install torch torchvision torchaudio

# Install backgroundremover
pip install backgroundremover

# Install photoidmagick
pip install photoidmagick

# Install cv2
pip install opencv-python

# Install argparse
pip install argparse

echo "We're done, enjoy."
# Installation script for dependencies of Aidm

# First, let me define a function for testing if given link for download is active or not
function test_url_active([string]$url) {
    try {
        $webRequest = New-Object System.Net.WebClient
        $webRequest.OpenRead($url)
        return $true
    } catch {
        return $false
    } finally {
        $webRequest.Dispose()
    }
}

echo "Installing Python..."

# Set an URL for downloading Python
$python_url = "https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe"

# Verify URL
if(-not (test_url_active $python_url)){
    echo "$python_url is unreachable"
    exit 1
}


# Set a path for downloading Python
$installer = "$env:TEMP\python-3.11.8-amd64.exe"

# Download Python installer
Invoke-WebRequest -Uri $python_url -OutFile $installer

# Install Python silently
Start-Process -FilePath $installer -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1", "Include_test=0" -Wait

# Remove the installer
Remove-Item $installer


echo "Installing pip..."

# Check if the version of pip is up to date and install lastest if not
py -m pip install --upgrade pip


echo "Installing cmake..."

# Set an URL for downloading cmake
$cmake_url = "https://github.com/Kitware/CMake/releases/download/v3.29.0-rc3/cmake-3.29.0-rc3-windows-x86_64.msi"

# Verify URL
if(-not (test_url_active $cmake_url)){
    echo "$cmake_url is unreachable"
    exit 1
}


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

    # Verify URL
    if(-not (test_url_active $7zip_url)){
        echo "$7zip_url is unreachable"
        exit 1
    }

    # Set a path for downloading 7zip
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

echo "Installing VS Build Tools for C++ ..."

# Set an URL for downloading vs
$vs_url = "https://aka.ms/vs/17/release/vs_BuildTools.exe"

# Verify URL
if(-not (test_url_active $vs_url)){
    echo "$vs_url is unreachable"
    exit 1
}

# Set a path for downloading vs
$installer = "$env:TEMP\vs_BuildTools.exe"

# Download vs installer
Invoke-WebRequest -Uri $vs_url -OutFile $installer

# Install vs silently
Start-Process -FilePath $installer -ArgumentList '--quiet', '--wait', '--norestart', '--nocache', '--installPath C:\BuildTools', '--add Microsoft.VisualStudio.Workload.VCTools', '--add Microsoft.VisualStudio.Component.VC.Tools.x86.x64', '--add Microsoft.VisualStudio.Component.VC.ATL', '--add Microsoft.VisualStudio.Component.VC.CLI.Support', '--add Microsoft.VisualStudio.Component.Windows10SDK.18362' -NoNewWindow -Wait

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

echo "Activating reg files for Aidm context menu GUI..."

regedit /c ".\reg\activation.reg"

echo "We're done, enjoy."

exit 0
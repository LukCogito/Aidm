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

# Install Python 3.12
winget install --id=Python.Python.3.12 --disable-interactivity --schope=machine

echo "Installing pip..."

# Check if the version of pip is up to date and install lastest if not
py -m pip install --upgrade pip


echo "Installing cmake..."

winget install --id=Kitware.CMake -e --disable-interactivity --scope=machine

echo "Defining paths..."

# Get the current value of the PATH environment variable
$Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

# Define the path to the cmake directory
$cmakePath = "C:\Program Files\CMake\bin\"

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

echo "Installing ffmpeg..."

winget install --id=Gyan.FFmpeg  -e --disable-interactivity --scope=machine

# Add virtual Python
$python_dir = "D:\Python\"
mkdir $python_dir
python -m venv $python_dir

# Activate virtual Python
$script_path = Join-Path -Path $python_dir "Scripts\activate.ps1"
Invoke-Expression -Command $script_path

echo "Installing essential Python packages via pip..."

$requirements_path = Join-Path -Path $PSScriptRoot "\requirements.txt"
pip install -r $requirements_path

echo "Activating reg files for Aidm context menu GUI..."

regedit /c ".\reg\activation.reg"

echo "We're done, enjoy."

exit 0
# Installation script for dependencies of Aim

# Install python from samba
\path\to\python.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

# Check if the version of pip is up to date and install lastest if not
py -m pip install --upgrade pip

# Install cmake
msiexec /i \path\to\cmake.msi /qn /norestart

# Get the current value of the PATH environment variable
$Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

# Define the path to the 7-Zip directory
$7ZipPath = "C:\Program Files\7-Zip\"

# Define the path to the cmake directory
$cmakePath = "C:\Program Files\CMake\bin\"

# Check if the 7-Zip path is already in the PATH environment variable
if (-not ($Path).Contains($7ZipPath)) {
    # If not, add the 7-Zip path to the PATH environment variable
    [System.Environment]::SetEnvironmentVariable("Path", $Path + ";" + $7ZipPath, "Machine")
}

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

# Install ffmpeg (free and open-source software project consisting of a suite of libraries and programs for handling video, audio, and other multimedia files and streams)
Invoke-WebRequest -Uri "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full.7z" -OutFile "ffmpeg.7z"
7z x ffmpeg.7z
$env:Path += ";$($pwd)\ffmpeg\bin"

# Install Visual Studio Build Tools for C++
Start-Process vs_BuildTools.exe -ArgumentList '--quiet', '--wait', '--norestart', '--nocache', '--installPath C:\BuildTools', '--add Microsoft.VisualStudio.Workload.VCTools', '--add Microsoft.VisualStudio.Component.VC.Tools.x86.x64', '--add Microsoft.VisualStudio.Component.VC.ATL', '--add Microsoft.VisualStudio.Component.VC.CLI.Support', '--add Microsoft.VisualStudio.Component.Windows10SDK.18362' -NoNewWindow -Wait

# Install PyTorch
pip install torch torchvision torchaudio

# Installing collected packages: mpmath, urllib3, typing-extensions, sympy, pillow, numpy, networkx, MarkupSafe, idna, fsspec, filelock, charset-normalizer, certifi, requests, jinja2, torch, torchvision, torchaudio

# Install backgroundremover
pip install backgroundremover

# Install photoidmagick
pip install photoidmagick

# Install cv2
pip install opencv-python

# Install argparse
pip install argparse
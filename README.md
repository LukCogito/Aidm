# Aidm: An AI ID Image Manipulation

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Requirements and Dependencies](#requirements-and-dependencies)
4. [Installation](#installation)
5. [Usage](#usage)
6. [License](#license)

## Overview

Aidm is a tool designed for editing ID photos, specifically for university ID cards and similar documents. This tool has been developed to simplify the process of photo editing and ensure consistent and professional results. Aidm is intended to be user-friendly and accessible even for those without prior photo editing experience.

## Features

Aidm offers a range of features for editing ID photos:

- Automatic cropping and alignment of the photo to the correct format and size.
- Color and brightness adjustment for optimal visibility and contrast.
- Background removal and addition of a new background as needed.
- Blur and sharpen functions to achieve the desired look.
- Red-eye correction for a more natural appearance.
- Easy-to-use context menu integration in Windows.
- Automatic installation of all necessary dependencies.

## Requirements and Dependencies

Aidm is written in PowerShell and Python and requires the following dependencies:

- Python 3.12 or higher
- Python libraries listed in the requirements.txt file
- CMake
- VS Build Tools for C++
- FFmpeg
- ImageMagick

## Installation

Installing Aidm is a straightforward process that involves running the installation script `installation_orion.ps1`. This script will install all necessary dependencies and configure the context menu in Windows.

1. Download or clone the Aidm repository from GitHub: https://github.com/LukCogito/Aidm.
2. Open PowerShell as an administrator and navigate to the repository folder.
3. Run the following command to execute the installation script:

   ```powershell
   .\installation_orion.ps1
   ```

4. The script will install all dependencies and configure the context menu. Once the installation is complete, you will see the message "We're done, enjoy."

## Usage

Aidm offers two usage options: "Standard Procedure" and separate functions.

### Standard Procedure

1. Right-click on the photo you want to edit and select "Aidm Standard Procedure".
2. Aidm will automatically perform a series of adjustments, including cropping, color correction, background removal, and addition of a new background.
3. The edited photos will be saved in the same folder as the original photo with the suffixes "_blue-background.jpg" and "_grey-background.jpg".

### Separate Functions

In addition to the standard procedure, Aidm also provides separate functions for photo editing:

- **Blur Image**: This function blurs the photo to achieve a soft focus look.
- **Sharpen Image**: This function enhances details and sharpens the photo.
- **Correct Red Eyes**: This function corrects red-eye in the photo.

To use these functions, simply right-click on the photo and select the desired option from the context menu. The edited photos will be saved in the same folder as the original photo.

## License

Aidm is provided under the GPL license. For more information, see the `LICENCE` file.

# Aidm: An AI ID Image Manipulation

## Obsah

1. [Přehled](#přehled)
2. [Funkce](#funkce)
3. [Požadavky a závislosti](#požadavky-a-závislosti)
4. [Instalace](#instalace)
5. [Použití](#použití)
6. [Licence](#licence)

## Přehled

Aidm je nástroj určený pro úpravu identifikačních fotografií, zejména pro potřeby univerzitních průkazů a podobných dokumentů. Tento nástroj byl vyvinut s cílem zjednodušit proces úpravy fotografií a zajistit konzistentní a profesionální výsledky. Aidm je navržen tak, aby byl snadno použitelný a přístupný i pro uživatele bez předchozích zkušeností s úpravou fotografií.

## Funkce

Aidm nabízí celou řadu funkcí pro úpravu identifikačních fotografií:

- Automatické oříznutí a zarovnání fotografie na správný formát a velikost.
- Úprava barev a jasu pro zajištění optimální viditelnosti a kontrastu.
- Odebrání pozadí a přidání nového pozadí podle potřeby.
- Možnost rozmazání nebo zaostření fotografie pro dosažení požadovaného vzhledu.
- Oprava červených očí pro dosažení přirozenějšího vzhledu.
- Snadné použití prostřednictvím kontextové nabídky ve Windows.
- Automatická instalace všech potřebných závislostí.

## Požadavky a závislosti

Aidm je napsán v PowerShellu a Pythonu a vyžaduje následující závislosti:

- Python 3.12 nebo vyšší
- Knihovny Pythonu uvedené v souboru requirements.txt
- CMake
- VS Build Tools for C++
- FFmpeg
- ImageMagick

## Instalace

Instalace Aidm je jednoduchý proces, který zahrnuje spuštění instalačního skriptu `installation_orion.ps1`. Tento skript nainstaluje všechny potřebné závislosti a nakonfiguruje kontextovou nabídku ve Windows.

1. Stáhněte si nebo naklonujte repozitář Aidm z GitHubu: https://github.com/LukCogito/Aidm.
2. Otevřete PowerShell jako správce a přejděte do složky s repozitářem.
3. Spusťte následující příkaz pro spuštění instalačního skriptu:

   ```powershell
   .\installation_orion.ps1
   ```

4. Skript nainstaluje všechny závislosti a nakonfiguruje kontextovou nabídku. Po dokončení instalace se zobrazí zpráva "We're done, enjoy."

## Použití

Aidm nabízí dvě možnosti použití: "Standard Procedure" a samostatné funkce.

### Standard Procedure

1. Klikněte pravým tlačítkem myši na fotografii, kterou chcete upravit, a vyberte "Aidm Standard Procedure".
2. Aidm automaticky provede celou řadu úprav, včetně oříznutí, úpravy barev, odebrání pozadí a přidání nového pozadí.
3. Upravené fotografie budou uloženy ve stejné složce jako původní fotografie s příponami "_blue-background.jpg" a "_grey-background.jpg".

### Samostatné funkce

Kromě standardní procedury nabízí Aidm také samostatné funkce pro úpravu fotografií:

- **Blur Image**: Tato funkce rozmaže fotografii pro dosažení rozostřeného vzhledu.
- **Sharpen Image**: Tato funkce zvýrazní detaily a zaostří fotografii.
- **Correct Red Eyes**: Tato funkce opraví červené oči na fotografii.

Chcete-li použít tyto funkce, jednoduše klikněte pravým tlačítkem myši na fotografii a vyberte požadovanou možnost z kontextové nabídky. Upravené fotografie budou uloženy ve stejné složce jako původní fotografie.

## Licence

Aidm je poskytován pod licencí GPL. Více informací naleznete v souboru `LICENCE`.
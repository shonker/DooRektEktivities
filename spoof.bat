@echo off
net session >nul 2>&1
if %errorLevel% == 0 (
    :: mount the efi partition to X: drive...
    mountvol X: /S
    
    :: bootmgfw is a system file so we are going to strip those attributes away...
    attrib -s -h X:\EFI\Microsoft\Boot\bootmgfw.efi
    
    :: backup original bootmgfw, spoofer restores it after loading
    move X:\EFI\Microsoft\Boot\bootmgfw.efi X:\EFI\Microsoft\Boot\bootmgfw.efi.bak
    
    xcopy %~dp0bootmgfw.efi X:\EFI\Microsoft\Boot\
    echo press enter to reboot...
    pause
    
    shutdown /r /t 0
) else (
    echo Failure: Please run as admin.
    pause
)
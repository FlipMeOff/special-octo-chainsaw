$wallpaperUrl = "https://wallpapers.com/images/hd/fbi-0sysysu1oomps69n.jpg"
$tempFilePath = "$env:TEMP\wallpaper.jpg"
Invoke-WebRequest -Uri $wallpaperUrl -OutFile $tempFilePath
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value 10
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02
[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $tempFilePath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)
Remove-Item $tempFilePath
$wallpaperUrl = "https://raw.githubusercontent.com/FlipMeOff/special-octo-chainsaw/main/imgs/1106067459619962920.3ps"
$tempFilePath = "$env:TEMP\wallpaper.png"
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

# Pixel Drive OS - Script de Extração de Segurança (K2001N / Allwinner T3)
# Autor: Jefferson da Silva Ramos

param(
    [Parameter(Mandatory=$true)]
    [string]$IpMultimidia
)

$Destino = "C:\Projetos\PixelDriveOS\dumps\K2001N_$(Get-Date -Format 'yyyyMMdd_HHmm')"
New-Item -ItemType Directory -Force -Path "$Destino\apks_sistema" | Out-Null

Write-Host "[1/4] Conectando via ADB Wi-Fi em ${IpMultimidia}:5555..." -ForegroundColor Cyan
adb connect "${IpMultimidia}:5555"

Write-Host "[2/4] Extraindo propriedades do hardware (build.prop)..." -ForegroundColor Cyan
adb shell getprop > "$Destino\getprop_completo.txt"
adb pull /system/build.prop "$Destino\build.prop" 2>$null
adb pull /vendor/build.prop "$Destino\vendor_build.prop" 2>$null

Write-Host "[3/4] Mapeando pacotes instalados e portas seriais UART..." -ForegroundColor Cyan
adb shell pm list packages -f > "$Destino\pacotes_instalados.txt"
adb shell ls -l /dev/tty* > "$Destino\portas_seriais_uart.txt"

Write-Host "[4/4] Buscando APKs de sistema (CAN Bus, MainUI, MCU)..." -ForegroundColor Cyan
$pacotes = adb shell pm list packages -f | Select-String -Pattern "can|mcu|car|ts|xy|tw|k2001"
foreach ($linha in $pacotes) {
    if ($linha -match "package:(.*\.apk)=") {
        $caminhoApk = $matches[1]
        Write-Host " -> Baixando $caminhoApk" -ForegroundColor Yellow
        adb pull $caminhoApk "$Destino\apks_sistema\"
    }
}

Write-Host "Backup concluido em: $Destino" -ForegroundColor Green

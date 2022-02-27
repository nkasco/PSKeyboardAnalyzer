####################################################################################################
# PS Keyboard Analyzer - A utility to help ensure keyboards aren't doing things they shouldn't     #
# Written by: Nathan Kasco                                                                         #
# Date: 2/27/2022                                                                                  #
####################################################################################################

function Get-PNPDevices{
    try{
        Get-WmiObject -Class win32_pnpdevice -ErrorAction Stop
    } catch {
        Write-Error "$_"
        Read-Host "Press enter to exit..."
        exit 1603
    }
}

Write-Progress -Activity "Starting PS Keyboard Analyzer" -Status "Initializing"
$Before = Get-PNPDevices
Write-Progress -Activity " " -Completed

Read-Host "Please plug in your keyboard and press enter to continue..."

Write-Progress -Activity "PS Keyboard Analyzer" -Status "Analyzing"
$After = Get-PNPDevices
Write-Progress -Activity " " -Completed

Write-Host "The following devices were added to the system:"
Compare-Object $Before $After -PassThru | Select-Object -ExpandProperty Path
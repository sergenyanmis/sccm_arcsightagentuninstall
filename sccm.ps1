$services= Get-WmiObject -Class Win32_Service | Where-Object {$_.DisplayName -like 'ArcSight*'}

 

foreach ($service in $services) {

                $path = $service.PathName

                $currentIndex = $path.IndexOf('\current\')

               

                if ($currentIndex -ne -1) {

                               $arcSightPath = $path.Substring(0, $currentIndex + 9)

                               $arcSightPath = $arcSightPath -replace '"', ''

                               $uninstallPath = Join-Path -Path $arcSightPath -ChildPath 'UninstallerData\Uninstall_ArcSightAgents.exe'

                               $command = "$uninstallPath -i silent"

                              

                               Write-Output $arcSightPath

                               Start-Process -FilePath $uninstallPath -ArgumentList 'i', 'silent' -Wait

                              

                }

}
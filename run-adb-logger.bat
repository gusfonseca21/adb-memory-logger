@ECHO OFF
TITLE ADB Memory Logger

setlocal enabledelayedexpansion
set "currentDirectory=%CD%"

echo Checando por dispositivos conectados...
for /f %%i in ('adb devices') do set /a count+=1

if !count! leq 1 (
    goto DEVICEADDRESSINPUT
)
if !count! equ 2 (
    for /f "tokens=1" %%i in ('adb devices') do set "deviceIp=%%i"
    echo Dispositivo conectado: !deviceIp!
    choice /c sn /m "Deseja se manter conectado a esse dispositivo?"
    if not !errorlevel! equ 1 (
        adb disconnect
        goto DEVICEADDRESSINPUT
    ) else (
        goto INPUTS
    )
)
if !count! geq 3 (
    choice /c sn /m "Existem dois ou mais dispositivos conectados. Deseja se disconectar de todos para continuar?"
    if !errorlevel! equ 1 (
        adb disconnect
        goto DEVICEADDRESSINPUT
    ) else (
        echo Fechando programa...
        pause
        goto :eof
    )
)

:DEVICEADDRESSINPUT
set /p deviceIp=Digite o IP do dispositivo a ser conectado:
echo Tentando se conectar ao dispositivo...
for /f "delims=" %%i in ('adb connect !deviceIp!') do set "connectOutput=%%i"
echo !connectOutput! | findstr /c:"connected to" >nul
if errorlevel 1 (
    echo Nao foi possivel se conectar ao dispositivo
    goto :DEVICEADDRESSINPUT
) else (
    echo Conexao realizada com sucesso
    goto :INPUTS
)

:INPUTS
set "logsDirectoryPath=%currentDirectory%\logs"

set /p "logFileName=Digite o nome para o arquivo de log: "

set /p "appPackage=Qual o aplicativo deseja monitorar? (Ex: com.instagram.android) "

set /p "interval=Intervalo entre os logs em segundos: "

set /a "interval=!interval!"

set /p "durationInput=Duracao da coleta de logs em minutos (0 para rodar indefinitivamente): "

set /a "duration=!durationInput!"

if !duration! equ 0 (
   set /a "duration=99999999"
)

set /a "finalHour=(!timeInMinutes! + !duration!) / 60"

set /a "finalMinutes=(!timeInMinutes! + !duration!) %%60"

set "logHeader=Inicio: !date! !time! - App: !appPackage! - Intervalo: !interval! seg - Duracao: !duration! min - Log: !logFileName!.txt"

set /a "counter=0"



for /f "tokens=1-2 delims=:" %%a in ("%time%") do (
    set "initialHour=%%a"
    set "initialMinutes=%%b"
)

set /a "timeInMinutes=(!initialHour! * 60) + !initialMinutes!"


set /a "hourToFinish=!initialHour! + !finalHour!"

set /a "minutesToFinish=!initialMinutes! + !finalMinutes!"



if not exist "%logsDirectoryPath%" (
     mkdir "%logsDirectoryPath%"
)

    SET "logfile=%logsDirectoryPath%\!logFileName!.txt"
    type nul > "!logfile!"
    echo !logHeader!>> "!logfile!"

    :LOOP
    for /f "tokens=1-3 delims=:" %%a in ("%time%") do (
        set "currentHour=%%a"
        set "currentMinutes=%%b"
        set "currentSeconds=%%c"
        set /a "hourDigits=!currentHour!"
        if !hourDigits! leq 9 (
            set "currentHour=0!currentHour!"
            set "currentHour=!currentHour: =!"
        )
        set "currentTime=!currentHour!:!currentMinutes!:!currentSeconds!"
    )

    if !currentHour! equ !hourToFinish! if !currentMinutes! equ !minutesToFinish! (
        goto CREATEGRAPH
    )

    for /f "tokens=2,3" %%i in ('adb shell dumpsys meminfo %appPackage% ^| findstr /C:"TOTAL"') do (
        if not defined flag (
            set "memory=%%i"
            echo !date! !currentTime! !memory!>> "!logfile!"
            set flag=1
        )
    )

    set /a "counter+=1"
    if !counter! gtr 0 (
    echo Contador: !counter! -- Hora: !currentTime! -- Memoria utilizada pelo app: !memory!
    )
    timeout /t !interval! >nul
    set "flag="

    goto LOOP


    :CREATEGRAPH
    cd .\chart-scripts\
    choice /c sn /m "Deseja visualizar o grafico com os logs gerados?"
    set "userChoice=!errorlevel!"

    if !userChoice! equ 1 (
        call create-chart-standalone.bat
        pause
    ) else (
        goto END
    )

    :END
    endlocal
    goto :eof
@ECHO OFF
TITLE ADB Memory Logger

setlocal enabledelayedexpansion

set "currentDirectory=%CD%"
set /p deviceIp=Digite o IP do dispositivo:
cd ./adb
ECHO Conectando ao dispositivo...
ECHO.
adb connect %deviceIp%
ECHO.

set "logsDirectoryPath=%currentDirectory%\logs"

set /p "logFileName=Digite o nome para o arquivo de log: "

set /p "appPackage=Qual o aplicativo deseja monitorar? (Ex: com.instagram.android) "

set /p "interval=Intervalo entre os logs em segundos: "

set /a "interval=!interval!"

set /p "durationInput=Duracao da coleta de logs em minutos: "

set /a "duration=!durationInput!"


set /a "finalHour=(!timeInMinutes! + !duration!) / 60"

set /a "finalMinutes=(!timeInMinutes! + !duration!) %%60"

set "logHeader=Log de Memoria - Iniciado em: !date! as !time! - Aplicativo monitorado: !appPackage! - Intervalo entre logs: !interval! segundos - Duracao do monitoramento: !duration! minutos - Nome do arquivo de log: !logFileName!"

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
    for /f "tokens=1-2 delims=:" %%a in ("%time%") do (
        set "currentHour=%%a" 
        set "currentMinutes=%%b"
    )

    if !currentHour! equ !hourToFinish! if !currentMinutes! equ !minutesToFinish! (
        goto CREATEGRAPH
    )

    for /f "tokens=2,3" %%i in ('adb shell dumpsys meminfo %appPackage% ^| findstr /C:"TOTAL"') do (
        if not defined flag (
            set "memory=%%i"
            echo !date! !time! !memory!>> "!logfile!"
            set flag=1
        )
    )




    set /a "counter+=1"
    if !counter! gtr 0 (
    echo Contador: !counter! -- Hora: !time! -- Memoria utilizada pelo app: !memory!
    )
    timeout /t !interval! >nul
    set "flag="

    goto LOOP


    :CREATEGRAPH
    cd %currentDirectory%\scripts\
    choice /c sn /m "Deseja visualizar o grafico com os logs gerados?"
    set "userChoice=!errorlevel!"
    
    echo Checando dependencias...
    where python > nul 2>&1
    if errorlevel 1 (
        echo Python nao foi encontrado
        PAUSE
        goto END
    )


    pip show pandas > nul 2>&1
    if errorlevel 1 (
        echo Instalando dependencia: pandas
        pip install pandas
    )
    pip show matplotlib > nul 2>&1
    if errorlevel 1 (
        echo Instalando dependência: matplotlib
        pip install matplotlib
    )

    if !userChoice! equ 1 (
        python create-graph.py !logFileName! show
        choice /c sn /m "Deseja salvar o gráfico gerado?"
        if !errorlevel! == "s" (
            goto :SAVEGRAPH
        ) else (
            PAUSE
        )
        PAUSE
    ) else (
        choice /c sn /m "Deseja salvar o gráfico gerado?"
        if !errorlevel! == "s" (
            goto :SAVEGRAPH
        )
    )

    :SAVEGRAPH
        python create-graph.py !logFileName! save


    :END
    endlocal
    PAUSE
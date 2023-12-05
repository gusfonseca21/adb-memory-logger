 @ECHO OFF
 setlocal enabledelayedexpansion

choice /c sn /m "Verificar dependencias?"
if errorlevel 2 (
    goto :eof
) else (
    goto :CHECK
)

:CHECK
echo Checando dependencias...
where python > nul 2>&1
if errorlevel 1 (
    echo Python nao foi encontrado
    PAUSE
) else (
    pip show pandas > nul 2>&1
    if errorlevel 1 (
        echo Instalando dependencia: pandas
        pip install pandas
    )
    pip show matplotlib > nul 2>&1
    if errorlevel 1 (
        echo Instalando dependencia: matplotlib
        pip install matplotlib
    )
)
endlocal
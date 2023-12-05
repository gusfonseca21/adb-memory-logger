@echo off

setlocal enabledelayedexpansion

call check-python-dependencies.bat 

set "currentDirectory=%CD%"

set /p "logName=Nome do arquivo a ser usado para gerar o log. Ex: log-teste-instagram (sem .txt): "
set /p "ticksDistance=Distancia entre os ticks de logs no eixo X (Ex: 50): "
set /p "memAggregation=Numero de logs agregados para a media do uso de memoria (Ex:100): "

python create-chart.py !logName! show !ticksDistance! !memAggregation!
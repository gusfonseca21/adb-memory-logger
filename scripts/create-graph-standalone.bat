@echo off

setlocal enabledelayedexpansion

set "currentDirectory=%CD%"

set /p "logName=Nome do arquivo a ser usado para gerar o log. Ex: log-teste-instagram (sem .txt no final): "

python create-graph.py !logName!
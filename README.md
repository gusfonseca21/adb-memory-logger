<<<<<<< HEAD
# ADB MEMORY LOGGER - Português

Ferramenta para automatizar a tarefa de gerar logs e gráficos do consumo de memória de um aplicativo específico em dispositivos Android por um período determinado.

Baseado no ADB (Android Debugger Bridge), ferramenta disponibilizada pelo Android Studio para fornecer uma shell onde podemos executar diversos comandos em dispositivos Android conectados localmente.
Para saber mais sobre o ADB: https://developer.android.com/studio/command-line/adb?hl=pt-br

### Descrição das pastas e arquivos:

- **run.bat**: Arquivo de inicialização do programa, escrito em BATCH.
- **/adb**: Pasta onde está o ferramentário ADB, que será utilizado para gerar os códigos.
- **/charts**: Local onde as imagens geradas a partir dos logs serão armazenadas em formato PNG.
- **/logs**: Local de armazenamento dos arquivos .txt com os dados dos logs.
- **/scripts**: Pasta onde se encontra o código, escrito em python, referente à geração dos gráficos.
  - **create-chart.py**: Código em python que lida com a geração do gráfico.
  - **create-chart-standalone.bat**: Pode ser utilizado caso já possua algum arquivo .txt com logs e queira apenas gerar um gráfico.

# ADB MEMORY LOGGER - English

Tool to automate the task of generating logs and charts of memory consumption for a specific application on Android devices over a specified period.

Based on ADB (Android Debugger Bridge), a tool provided by Android Studio to provide a shell where various commands can be executed on locally connected Android devices.
For more information about ADB, refer to the [Android Studio Command Line documentation](https://developer.android.com/studio/command-line/adb?hl=en).

### Folder and File Descriptions:

- **run.bat**: Program initialization file, written in BATCH.
- **/adb**: Folder containing the ADB toolkit, which will be used to generate codes.
- **/charts**: Location where images generated from the logs will be stored in PNG format.
- **/logs**: Storage location for .txt files containing log data.
- **/scripts**: Folder containing the Python code for generating the charts.
  - **create-chart.py**: Python code handling the chart generation.
  - **create-chart-standalone.bat**: Can be used if you already have a .txt file with logs and just want to generate a chart.
=======
# ADB MEMORY LOGGER - Português

Ferramenta para automatizar a tarefa de gerar logs e gráficos do consumo de memória de um aplicativo específico em dispositivos Android por um período determinado.

Baseado no ADB (Android Debugger Bridge), ferramenta disponibilizada pelo Android Studio para fornecer uma shell onde podemos executar diversos comandos em dispositivos Android conectados localmente.
Para saber mais sobre o ADB: https://developer.android.com/studio/command-line/adb?hl=pt-br

### Descrição das pastas e arquivos:

- **run.bat**: Arquivo de inicialização do programa, escrito em BATCH.
- **/adb**: Pasta onde está o ferramentário ADB, que será utilizado para gerar os códigos.
- **/graphs**: Local onde as imagens geradas a partir dos logs serão armazenadas em formato PNG.
- **/logs**: Local de armazenamento dos arquivos .txt com os dados dos logs.
- **/scripts**: Pasta onde se encontra o código, escrito em python, referente à geração dos gráficos.
  - **create-graph.py**: Código em python que lida com a geração do gráfico.
  - **create-graph-standalone.bat**: Pode ser utilizado caso já possua algum arquivo .txt com logs e queira apenas gerar um gráfico.


# ADB MEMORY LOGGER - English

Tool to automate the task of generating logs and charts of memory consumption for a specific application on Android devices over a specified period.

Based on ADB (Android Debugger Bridge), a tool provided by Android Studio to provide a shell where various commands can be executed on locally connected Android devices.
For more information about ADB, refer to the [Android Studio Command Line documentation](https://developer.android.com/studio/command-line/adb?hl=en).

### Folder and File Descriptions:

- **run.bat**: Program initialization file, written in BATCH.
- **/adb**: Folder containing the ADB toolkit, which will be used to generate codes.
- **/graphs**: Location where images generated from the logs will be stored in PNG format.
- **/logs**: Storage location for .txt files containing log data.
- **/scripts**: Folder containing the Python code for generating the charts.
  - **create-graph.py**: Python code handling the chart generation.
  - **create-graph-standalone.bat**: Can be used if you already have a .txt file with logs and just want to generate a chart.
>>>>>>> 4c0beed0c5c02f00ab02d5b97af5814ddab0d5c0

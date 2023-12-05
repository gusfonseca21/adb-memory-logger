<<<<<<< HEAD

# ADB MEMORY LOGGER - Português

Ferramenta para automatizar a tarefa de gerar logs e gráficos do consumo de memória de um aplicativo específico em dispositivos Android por um período determinado.

Baseado no ADB (Android Debugger Bridge), ferramenta disponibilizada pelo Android Studio para fornecer uma shell onde podemos executar diversos comandos em dispositivos Android conectados localmente.
Para saber mais sobre o ADB: https://developer.android.com/studio/command-line/adb?hl=pt-br

### Descrição das pastas e arquivos:

- **adb-memory-logger.bat**: Arquivo de inicialização do programa, escrito em BATCH.
- **/adb**: Pasta onde está o ferramentário ADB, que será utilizado para gerar os códigos.
- **/charts**: Local onde as imagens geradas a partir dos logs serão armazenadas em formato PNG.
- **/logs**: Local de armazenamento dos arquivos .txt com os dados dos logs.
- **/chart-scripts**: Pasta onde se encontra o código, escrito em python, referente à geração dos gráficos.
  - **create-chart.py**: Código em python que lida com a geração do gráfico.
  - **create-chart-standalone.bat**: Pode ser utilizado caso já possua algum arquivo .txt com logs e queira apenas gerar um gráfico.
  - **check-python-dependencies.bat**: Script utiliado para checar as dependências relacionadas ao Python para a geração dos gráficos.

# ADB MEMORY LOGGER - English

Tool to automate the task of generating logs and charts of memory consumption for a specific application on Android devices over a specified period.

Based on ADB (Android Debugger Bridge), a tool provided by Android Studio to provide a shell where various commands can be executed on locally connected Android devices.
For more information about ADB, refer to the [Android Studio Command Line documentation](https://developer.android.com/studio/command-line/adb?hl=en).

### Folder and File Descriptions:

- **adb-memory-logger.bat**: Initialization file of the program, written in BATCH.
- **/adb**: Folder where the ADB toolset is located, which will be used to generate codes.
- **/charts**: Location where images generated from the logs will be stored in PNG format.
- **/logs**: Storage location for .txt files containing log data.
- **/chart-scripts**: Folder containing Python code related to chart generation.
  - **create-chart.py**: Python code handling the chart generation.
  - **create-chart-standalone.bat**: Can be used if you already have a .txt log file and just want to generate a chart.
  - **check-python-dependencies.bat**: Script used to check Python dependencies for chart generation.

# EXEMPLO DO LOG | LOG EXAMPLES

Inicio: 27/11/2023 18:43:12,22 - App: com.instagram.android - Intervalo: 10 seg - Duracao: 999999min - Log: teste-instagram.txt

27/11/2023 18:43:12,23 155760

27/11/2023 18:43:23,21 128961

27/11/2023 18:43:34,13 181770

27/11/2023 18:43:45,16 182802

27/11/2023 18:43:56,18 178902

27/11/2023 18:44:07,14 178882

27/11/2023 18:44:18,19 174810

27/11/2023 18:44:29,21 174693

...

# EXEMPLOS DE GRÁFICOS | CHART EXAMPLES

![image](https://github.com/gusfonseca21/adb-memory-logger/assets/104652205/7a7831bc-af74-454f-8920-6f662f817a78)

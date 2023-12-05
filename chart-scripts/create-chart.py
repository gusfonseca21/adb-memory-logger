import os
import sys
import pandas as pd
import matplotlib.pyplot as plt

script_path = os.path.abspath(__file__)
log_directory = "..\\logs\\"

file_name = sys.argv[1]
file_path = os.path.join(log_directory, file_name + ".txt")
show_or_save = sys.argv[2]
ticks_distance = int(sys.argv[3])
mem_aggregation= int(sys.argv[4])



if show_or_save not in ["show", "save"]:
    print("O argumento 'show' ou 'save' não foi utilizado corretamente")
    input("Aperte ENTER para continuar...")



# Check if the file exists
if os.path.exists(file_path):
    df = pd.read_csv(
        file_path,
        sep=" ",
        skiprows=1,
        # nrows=1,
        header=None,
        skipinitialspace=False,
        names=[
            "date",
            "time",
            'memory'
        ],
    )
    
    with open(file_path, 'r') as file:
        log_header = file.readline()
    df["timestamp"] = pd.to_datetime(df["date"] + " " + df["time"], format="%d/%m/%Y %H:%M:%S,%f")

    fig, ax = plt.subplots(figsize=(10, 6))
    average_memory = df['memory'].rolling(window=mem_aggregation, center=False).mean()
    # average_memory = average_memory.fillna(method='bfill')
    average_memory = average_memory.bfill()


    ax.plot(df["timestamp"], df["memory"], linestyle="-", label="Uso de Memória pelo app")
    ax.plot(df['timestamp'], average_memory, label=f'Média de Memória (A cada {mem_aggregation} Logs)', linestyle='--', color='red')

    # Customize the plot
    plt.title(f"{log_header}", fontsize=10)
    plt.xlabel("Hora")
    plt.ylabel("Memória em Kilobytes")

    # Set x-axis labels manually in the format HH:MM:SS for every 50th timestamp
    labels = [
        ts.strftime("%H:%M:%S") for i, ts in enumerate(df["timestamp"]) if i % ticks_distance == 0
    ]
    ax.set_xticks(df["timestamp"][::ticks_distance])
    ax.set_xticklabels(labels, rotation=45)

    plt.legend()
    plt.grid(True, linestyle="--", alpha=0.7)
    plt.gca().set_facecolor('#f2f2f2')

    if show_or_save == "show":
        plt.show()

    if show_or_save == "save":
        plt.savefig(os.path.join("../charts", file_name))


else:
    print(f"File not found: {file_path}")
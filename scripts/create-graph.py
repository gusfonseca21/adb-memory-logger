import os
import sys
import pandas as pd
import matplotlib.pyplot as plt

script_path = os.path.abspath(__file__)
log_directory = "..\\logs\\"

file_name = sys.argv[1]
file_path = os.path.join(log_directory, file_name + ".txt")
show_or_save = sys.argv[2]

if show_or_save not in ["show", "save"]:
    print("O argumento 'show' ou 'save' não foi utilizado corretamente")
    input("Aperte ENTER para continuar...")



# Check if the file exists
if os.path.exists(file_path):
    # Read the CSV file into a DataFrame

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
    
    df["time"] = pd.to_datetime(df["date"] + " " + df["time"], format="%d/%m/%Y %H:%M:%S,%f")
    

    df["time"] = df["time"].apply(
        lambda x: x.hour * 3600 + x.minute * 60 + x.second + x.microsecond / 1e6
    )

    df["time"] = pd.to_datetime(df["time"], unit="s")

    fig, ax = plt.subplots(figsize=(10, 6))
    ax.plot(df["time"], df["memory"], marker="o", linestyle="-", label="Uso de Memória pelo app")

    # Customize the plot
    plt.title(f"{log_header}", fontsize=10)
    plt.xlabel("Hora")
    plt.ylabel("Memória em Kilobyte")

    # Set x-axis labels manually in the format HH:MM:SS for every 50th timestamp
    labels = [
        ts.strftime("%H:%M:%S") for i, ts in enumerate(df["time"]) if i % 50 == 0
    ]
    ax.set_xticks(df["time"][::50])
    ax.set_xticklabels(labels, rotation=45)

    plt.legend()
    plt.grid(True, linestyle="--", alpha=0.7)
    plt.gca().set_facecolor('#f2f2f2')


    # Show the plot
    if show_or_save == "show":
        plt.show()

    if show_or_save == "save":
        plt.savefig(os.path.join("../graphs", file_name))


else:
    print(f"File not found: {file_path}")
import matplotlib.pyplot as plt
from collections import Counter
from datetime import datetime

def visualizar_atendimentos_por_dia(dates):
    # Converter as strings de data para objetos do tipo datetime
    dates = [datetime.strptime(date, "%Y-%m-%d") for date in dates]

    # Contar a quantidade de atendimentos por dia
    atendimentos_por_dia = Counter(dates)

    # Ordenar as datas em ordem crescente
    datas_ordenadas = sorted(atendimentos_por_dia.keys())

    # Obter a quantidade de atendimentos para cada dia ordenado
    qtd_atendimentos = [atendimentos_por_dia[data] for data in datas_ordenadas]

    # Plotar o gráfico de barras
    plt.figure(figsize=(10, 6))
    plt.bar(datas_ordenadas, qtd_atendimentos)
    plt.xlabel("Data do Atendimento")
    plt.ylabel("Quantidade de Atendimentos")
    plt.title("Quantidade de Atendimentos Médicos por Dia")
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()


# Exemplo de uso da função com uma lista de datas
datas_atendimentos = ["2023-07-20", "2023-07-21", "2023-07-21", "2023-07-22", "2023-07-23", "2023-07-23", "2023-07-23"]
visualizar_atendimentos_por_dia(datas_atendimentos)

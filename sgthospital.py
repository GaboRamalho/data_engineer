import pandas as pd
import requests
from sqlalchemy import create_engine

# Caminho do arquivo CSV contendo os procedimentos médicos do SIGTAP
csv_file = 'tabela-sigtap-201904.csv'

# Leitura do arquivo CSV e armazenamento dos dados em um DataFrame
df = pd.read_csv(csv_file, sep=';')

# Configuração da conexão com o banco de dados
config = {
    'host': 'localhost',          # Endereço do banco de dados
    'user': 'root',               # Usuário do banco de dados
    'password': 'teste1234',       # Senha do usuário
    'database': 'stg_hospital_sigtap'  # Nome do banco de dados
}

# Crie uma string de conexão usando a biblioteca SQLAlchemy
conn_str = f"mysql+mysqlconnector://{config['user']}:{config['password']}@{config['host']}/{config['database']}"

# Crie um engine do SQLAlchemy para realizar a conexão
engine = create_engine(conn_str)

# Gravação dos dados no banco de dados
df.to_sql(name='sigtap', con=engine, if_exists='append', index=False)

print('Dados importados com sucesso!')
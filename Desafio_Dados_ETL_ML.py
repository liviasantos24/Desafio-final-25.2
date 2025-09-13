https://colab.research.google.com/drive/1tmKJYaxL0LKHR1iNTGfUXYDL2W2iC8Na?authuser=0#scrollTo=8yzR3qM-2vgb

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

try:
    df = pd.read_csv('banco_box.csv')
    print("Dados carregados com sucesso!")
except FileNotFoundError:
    print("Erro: O arquivo 'banco_box.csv' não foi encontrado. Verifique o caminho.")

    data = {
        'id_cliente': [1, 2, 3, 4, 5],
        'renda_mensal': ['5000', '3500', '7000', '2000', '10000'],
        'dividas_total': ['1500', '3000', '800', '500', '5000'],
        'historico_credito': [720, 680, 800, 550, 750],
        'risco': ['Baixo', 'Alto', 'Baixo', 'Médio', 'Baixo']
    }
    df = pd.DataFrame(data)

print("\n--- Informações iniciais do DataFrame ---")
print(df.head())
print("\n--- Tipos de dados das colunas ---")
print(df.info())

df['renda_mensal'] = pd.to_numeric(df['renda_mensal'].astype(str).str.replace(',', '.'), errors='coerce')
df['dividas_total'] = pd.to_numeric(df['dividas_total'].astype(str).str.replace(',', '.'), errors='coerce')

df['renda_mensal'].fillna(df['renda_mensal'].mean(), inplace=True)
df['dividas_total'].fillna(df['dividas_total'].mean(), inplace=True)

df['relacao_divida_renda'] = df.apply(
    lambda row: row['dividas_total'] / row['renda_mensal'] if row['renda_mensal'] > 0 else 0,
    axis=1
)

df.to_csv('banco_box_tratado.csv', index=False)
print("\nDados tratados salvos em 'banco_box_tratado.csv' com sucesso!")

print("\n--- DataFrame após a transformação ---")
print(df.head())
print("\n--- Tipos de dados após a transformação ---")
print(df.info())



import matplotlib.pyplot as plt

print("--- Análise exploratória de dados ---")

contagem_risco = df['risco'].value_counts()

plt.figure(figsize=(8, 6))
contagem_risco.plot(kind='bar', color=['skyblue', 'lightcoral', 'lightgreen'])
plt.title('Distribuição de Clientes por Nível de Risco')
plt.xlabel('Nível de Risco')
plt.ylabel('Número de Clientes')
plt.xticks(rotation=0)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()

media_renda_por_risco = df.groupby('risco')['renda_mensal'].mean().sort_values(ascending=False)

plt.figure(figsize=(8, 6))
media_renda_por_risco.plot(kind='bar', color=['gold', 'coral', 'mediumseagreen'])
plt.title('Média da Renda Mensal por Nível de Risco')
plt.xlabel('Nível de Risco')
plt.ylabel('Média da Renda Mensal (R$)')
plt.xticks(rotation=0)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()

media_relacao_divida_renda_por_risco = df.groupby('risco')['relacao_divida_renda'].mean().sort_values(ascending=False)

plt.figure(figsize=(8, 6))
media_relacao_divida_renda_por_risco.plot(kind='bar', color=['lightpink', 'purple', 'lightgrey'])
plt.title('Média da Relação Dívida/Renda por Nível de Risco')
plt.xlabel('Nível de Risco')
plt.ylabel('Média da Relação Dívida/Renda')
plt.xticks(rotation=0)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()

media_historico_credito = np.mean(df['historico_credito'])

print(f"\nMédia do histórico de crédito dos clientes: {media_historico_credito:.2f}")

media_por_risco = df.groupby('risco')['historico_credito'].mean()
print("\nMédia do Histórico de Crédito por Nível de Risco:")
print(media_por_risco)


from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix
import seaborn as sns

print("--- Preparando os dados para o modelo ---")

X = df[['renda_mensal', 'dividas_total', 'historico_credito', 'relacao_divida_renda']]
y = df['risco']

X_treino, X_teste, y_treino, y_teste = train_test_split(X, y, test_size=0.3, random_state=42)

print(f"Dados de treino: {X_treino.shape[0]} amostras")
print(f"Dados de teste: {X_teste.shape[0]} amostras")

modelo = DecisionTreeClassifier(random_state=42)

print("\n--- Treinando o modelo de Árvore de Decisão ---")
modelo.fit(X_treino, y_treino)
print("Modelo treinado com sucesso!")

previsoes = modelo.predict(X_teste)

acuracia = accuracy_score(y_teste, previsoes)
print(f"\nAcurácia do modelo: {acuracia * 100:.2f}%")

print("\n--- Relatório de Classificação ---")
print(classification_report(y_teste, previsoes))

print("\n--- Matriz de Confusão ---")
cm = confusion_matrix(y_teste, previsoes, labels=['Alto', 'Médio', 'Baixo'])
plt.figure(figsize=(8, 6))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', xticklabels=['Alto', 'Médio', 'Baixo'], yticklabels=['Alto', 'Médio', 'Baixo'])
plt.title('Matriz de Confusão')
plt.xlabel('Previsão')
plt.ylabel('Real')
plt.show()

print("\n--- Exemplo de Previsão para um novo cliente ---")
novo_cliente = [[12000, 3000, 750, 0.25]]
previsao_novo_cliente = modelo.predict(novo_cliente)
print(f"Para o novo cliente com renda de R$12.000, a previsão de risco é: {previsao_novo_cliente[0]}")

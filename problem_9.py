def verificar_prescricao(prescricao, estoque):
    # Criar dicionários para contar a frequência de cada medicamento na prescrição e no estoque
    prescricao_freq = {}
    estoque_freq = {}

    # Contar a frequência de cada medicamento na prescrição
    for medicamento in prescricao:
        prescricao_freq[medicamento] = prescricao_freq.get(medicamento, 0) + 1

    # Contar a frequência de cada medicamento no estoque
    for medicamento in estoque:
        estoque_freq[medicamento] = estoque_freq.get(medicamento, 0) + 1

    # Verificar se todos os medicamentos prescritos estão no estoque e se há quantidade suficiente
    for medicamento, dose_prescrita in prescricao_freq.items():
        if medicamento not in estoque_freq or estoque_freq[medicamento] < dose_prescrita:
            return False

    return True


# Exemplos de uso da função
print(verificar_prescricao("a", "b"))  # Saída: False
print(verificar_prescricao("aa", "baaca"))  # Saída: False
print(verificar_prescricao("aa", "aab"))  # Saída: True
print(verificar_prescricao("aba", "cbaa"))  # Saída: True

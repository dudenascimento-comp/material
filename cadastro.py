class Data:
    def __init__(self, dia: int, mes: int, ano: int):
        self.dia = dia
        self.mes = mes
        self.ano = ano

class Pessoa:
    def __init__(self, nome: str, telefone: str, nascimento: Data):
        self.nome = nome
        self.telefone = telefone
        self.nascimento = nascimento

def menu():
    # Defina o tamanho máximo do grupo de pessoas aqui
    TAMANHO = 5
    grupo = []  # Lista que armazenará os objetos da classe Pessoa

    while True:
        print("\n--- MENU DE OPÇÕES ---")
        print("1. Cadastrar Pessoa")
        print("2. Consultar Aniversariantes do Mês")
        print("3. Sair")
        
        opcao = input("Escolha uma opção: ")

        if opcao == "1":
            if len(grupo) < TAMANHO:
                print("\n=== CADASTRAR PESSOA ===")
                nome = input("Nome: ")
                telefone = input("Telefone: ")
                
                try:
                    dia = int(input("Dia de nascimento: "))
                    mes = int(input("Mês de nascimento (1 a 12): "))
                    ano = int(input("Ano de nascimento: "))
                    
                    # Cria as estruturas encapsuladas
                    data_nasc = Data(dia, mes, ano)
                    nova_pessoa = Pessoa(nome, telefone, data_nasc)
                    
                    grupo.append(nova_pessoa)
                    print("\nCadastro realizado com sucesso!")
                except ValueError:
                    print("\nErro: Digite valores numéricos válidos para a data.")
            else:
                print("\nErro: Limite de cadastro atingido!")
                
        elif opcao == "2":
            if not grupo:
                print("\nNenhuma pessoa cadastrada ainda.")
            else:
                try:
                    mes_busca = int(input("\nDigite o número do mês que deseja consultar (1 a 12): "))
                    encontrou = False
                    
                    print(f"\n=== ANIVERSARIANTES DO MÊS {mes_busca} ===")
                    for pessoa in grupo:
                        # Compara o mês buscando dentro da estrutura de data da pessoa
                        if pessoa.nascimento.mes == mes_busca:
                            print(f"Nome: {pessoa.nome} | Tel: {pessoa.telefone} | "
                                  f"Data: {pessoa.nascimento.dia}/{pessoa.nascimento.mes}/{pessoa.nascimento.ano}")
                            encontrou = True
                            
                    if not encontrou:
                        print("Nenhum aniversariante encontrado neste mês.")
                except ValueError:
                    print("\nErro: Digite um número de mês válido.")
                    
        elif opcao == "3":
            print("\nSaindo do programa. Até logo!")
            break
        else:
            print("\nOpção inválida! Tente novamente.")

# Executa o programa
if __name__ == "__main__":
    menu()

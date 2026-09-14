programa {
  // Constantes para definir os limites do grafo
	const inteiro MAX_NODOS = 10
	const inteiro INFINITO = 999999
	
	// Matriz que armazena os pesos das conexões (arestas)
	inteiro grafo[MAX_NODOS][MAX_NODOS]
	
	// Vetor para saber quais nodos foram criados (verdadeiro/falso)
	logico nodos_existentes[MAX_NODOS]
	
	inteiro total_nodos = 0

  funcao inicio()
	{
		inteiro opcao, origem, destino, peso
		
		inicializar_grafo()
		
		faca {
			escreva("\n=== MENU GRAFO ===\n")
			escreva("1. Inserir Nodo\n")
			escreva("2. Inserir Conexão (Aresta)\n")
			escreva("3. Exibir Grafo (Matriz)\n")
			escreva("4. Encontrar Melhor Caminho (Dijkstra)\n")
			escreva("0. Sair\n")
			escreva("Escolha uma opção: ")
			leia(opcao)
			limpa()
			
			escolha(opcao)
			{
				caso 1:
					inserir_nodo()
					pare
				caso 2:
					escreva("Digite o nodo de ORIGEM (0 a ", MAX_NODOS - 1, "): ")
					leia(origem)
					escreva("Digite o nodo de DESTINO (0 a ", MAX_NODOS - 1, "): ")
					leia(destino)
					escreva("Digite o PESO/CUSTO da conexão (maior que 0): ")
					leia(peso)
					inserir_conexao(origem, destino, peso)
					pare
				caso 3:
					exibir_grafo()
					pare
				caso 4:
					escreva("Digite o nodo de INÍCIO: ")
					leia(origem)
					escreva("Digite o nodo de FIM: ")
					leia(destino)
					encontrar_melhor_caminho(origem, destino)
					pare
				caso 0:
					escreva("Programa encerrado.\n")
					pare
				caso contrario:
					escreva("Opção inválida!\n")
			}
		} enquanto(opcao != 0)
	}

  // Preenche a matriz com INFINITO e remove os nodos do sistema
	funcao inicializar_grafo()
	{
		para(inteiro i = 0; i < MAX_NODOS; i++)
		{
			nodos_existentes[i] = falso
			para(inteiro j = 0; j < MAX_NODOS; j++)
			{
				se (i == j) {
					grafo[i][j] = 0 // Custo de um nodo para ele mesmo é zero
				} senao {
					grafo[i][j] = INFINITO
				}
			}
		}
	}
  // Ativa o próximo ID de nodo disponível
	funcao inserir_nodo()
	{
		se (total_nodos < MAX_NODOS)
		{
			nodos_existentes[total_nodos] = verdadeiro
			escreva("Nodo ", total_nodos, " inserido com sucesso!\n")
			total_nodos++
		} senao {
			escreva("Erro: Limite máximo de nodos atingido (", MAX_NODOS, ").\n")
		}
	}

	// Cria uma conexão direcionada (peso) entre dois nodos existentes
	funcao inserir_conexao(inteiro origem, inteiro destino, inteiro peso)
	{
		se (origem >= MAX_NODOS ou destino >= MAX_NODOS ou nao nodos_existentes[origem] ou nao nodos_existentes[destino])
		{
			escreva("Erro: Um ou ambos os nodos informados não existem.\n")
		} senao se (peso <= 0) {
			escreva("Erro: O peso deve ser maior que zero.\n")
		} senao {
			grafo[origem][destino] = peso
			// Se o seu grafo for NÃO-DIRECIONADO (mão dupla), descomente a linha abaixo:
			// grafo[destino][origem] = peso
			escreva("Conexão inserida: ", origem, " -> ", destino, " (Peso: ", peso, ")\n")
		}
	}

	// Renderiza a matriz de adjacência na tela de forma limpa
	funcao exibir_grafo()
	{
		se (total_nodos == 0) {
			escreva("O grafo está vazio.\n")
			retorne
		}
		
		escreva("Visualização do Grafo (Matriz de Adjacência):\n\n     ")
		para(inteiro i = 0; i < total_nodos; i++) {
			escreva(i, "    ")
		}
		escreva("\n")
		
		para(inteiro i = 0; i < total_nodos; i++)
		{
			escreva(i, " |  ")
			para(inteiro j = 0; j < total_nodos; j++)
			{
				se (grafo[i][j] == INFINITO) {
					escreva("INF  ")
				} senao {
					escreva(grafo[i][j], "    ")
				}
			}
			escreva("\n")
		}
	}
  // Algoritmo de Dijkstra para encontrar o menor caminho
	funcao encontrar_melhor_caminho(inteiro inicio_nodo, inteiro fim_nodo)
	{
		se (inicio_nodo >= total_nodos ou fim_nodo >= total_nodos ou nao nodos_existentes[inicio_nodo] ou nao nodos_existentes[fim_nodo]) {
			escreva("Erro: Nodos inválidos.\n")
			retorne
		}

		inteiro distancia[MAX_NODOS]
		logico visitado[MAX_NODOS]
		inteiro predecessor[MAX_NODOS]

		// Configuração inicial das variáveis de controle
		para(inteiro i = 0; i < total_nodos; i++) {
			distancia[i] = INFINITO
			visitado[i] = falso
			predecessor[i] = -1
		}

		distancia[inicio_nodo] = 0

		para(inteiro cont = 0; cont < total_nodos - 1; cont++)
		{
			// Encontra o nodo com a menor distância atual que ainda não foi processado
			inteiro u = -1
			inteiro min_dist = INFINITO

			para(inteiro i = 0; i < total_nodos; i++) {
				se (nao visitado[i] e distancia[i] < min_dist) {
					min_dist = distancia[i]
					u = i
				}
			}

			// Se não encontrou nenhum nodo alcançável, para o processo
			se (u == -1) pare

			visitado[u] = verdadeiro

			// Atualiza as distâncias dos nodos vizinhos
			para(inteiro v = 0; v < total_nodos; v++) {
				se (nao visitado[v] e grafo[u][v] != INFINITO e distancia[u] != INFINITO) {
					se (distancia[u] + grafo[u][v] < distancia[v]) {
						distancia[v] = distancia[u] + grafo[u][v]
						predecessor[v] = u
					}
				}
			}
		}

		// Exibe o resultado obtido
		se (distancia[fim_nodo] == INFINITO) {
			escreva("Não existe caminho entre o nodo ", inicio_nodo, " e o nodo ", fim_nodo, ".\n")
		} senao {
			escreva("Melhor custo/distância: ", distancia[fim_nodo], "\n")
			escreva("Caminho a seguir: ")
			exibir_caminho_recursivo(predecessor, fim_nodo)
			escreva("\n")
		}
	}
	// Função auxiliar para rastrear e printar a ordem correta do caminho reconstruído
	funcao exibir_caminho_recursivo(inteiro predecessor[], inteiro nodo_atual)
	{
		se (predecessor[nodo_atual] == -1) {
			escreva(nodo_atual)
			retorne
		}
		exibir_caminho_recursivo(predecessor, predecessor[nodo_atual])
		escreva(" -> ", nodo_atual)
	}

	
}

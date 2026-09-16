programa
{
	inclua biblioteca Texto --> tx
	inclua biblioteca Util --> u
	
	funcao inicio()
	{
		cadeia palavraOriginal, palavraSorteada
		cadeia tentativa = ""
		inteiro tamanho
		
		// 1. Definição da palavra (pode ser expandido para um sorteio)
    escreva("Peça para um amigo digitar uma palavra para ser descoberta:")
		leia(palavraOriginal)
		tamanho = tx.numero_caracteres(palavraOriginal)
		
		// 2. Embaralhando usando algoritmo de troca/inversão
		palavraSorteada = embaralhar(palavraOriginal, tamanho)
		
		escreva("--- JOGO DO ANAGRAMA ---\n")
		escreva("Descubra a palavra original: ", palavraSorteada, "\n")
		
		enquanto (tentativa != palavraOriginal)
		{
			escreva("\nSeu palpite: ")
			leia(tentativa)
			//tentativa = tx.caixa_alta(tentativa)
			
			se (tentativa == palavraOriginal) {
				escreva("Parabéns! Você acertou.")
			} senao {
				escreva("Errado! Tente novamente.")
			}
		}
	}

	funcao cadeia embaralhar(cadeia p, inteiro tam)
	{
		cadeia letras[20] // Vetor para manipular os caracteres
		cadeia resultado = ""
		
		// Transforma a string em vetor
		para (inteiro i = 0; i < tam; i++) {
			letras[i] = tx.extrair_subtexto(p, i, i + 1)
		}

		// Algoritmo de inversão parcial e troca aleatória
		para (inteiro i = 0; i < tam; i++) {
			inteiro j = u.sorteia(0, tam - 1)
			cadeia aux = letras[i]
			letras[i] = letras[j]
			letras[j] = aux
		}

		// Reconstrói a string
		para (inteiro i = 0; i < tam; i++) {
			resultado = resultado + letras[i]
		}

		retorne resultado
	}
}

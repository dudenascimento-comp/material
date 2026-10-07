import matplotlib.pyplot as plt
import networkx as nx

# 1. Inicializa um grafo não direcionado (conexões bidirecionais, como no Facebook)
# Se fosse uma rede de seguidores (como Instagram/Twitter), usaríamos nx.DiGraph()
rede_social = nx.Graph()

# 2. Adiciona os nós (os usuários da rede social)
usuarios = ["Alice", "Bob", "Charlie", "David", "Eva", "Frank"]
rede_social.add_nodes_from(usuarios)

# 3. Adiciona as arestas (as conexões/amizades entre eles)
conexoes = [
    ("Alice", "Bob"),
    ("Alice", "Charlie"),
    ("Bob", "Charlie"),
    ("Bob", "David"),
    ("Charlie", "Eva"),
    ("David", "Eva"),
    ("Eva", "Frank"),
]
rede_social.add_edges_from(conexoes)

# 4. Configura a exibição visual do grafo
plt.figure(figsize=(8, 6))
plt.title("Grafo de Conexões na Rede Social", fontsize=14, fontweight="bold")

# Define o layout (forma como os nós serão distribuídos na tela)
posicao = nx.spring_layout(rede_social, seed=42)

# Desenha os nós, conexões e rótulos
nx.draw_networkx_nodes(
    rede_social, posicao, node_size=900, node_color="skyblue"
)
nx.draw_networkx_edges(rede_social, posicao, width=2, edge_color="gray")
nx.draw_networkx_labels(
    rede_social, posicao, font_size=12, font_family="sans-serif"
)

# Remove os eixos cartesianos da imagem de fundo
plt.axis("off")

# 5. Exibe o gráfico na tela
plt.show()

# --- Extra: Análise simples da rede ---
print("--- Estatísticas da Rede Social ---")
for usuario in rede_social.nodes():
    # O grau (degree) representa o número de conexões de um nó
    print(f"{usuario} tem {rede_social.degree(usuario)} conexões.")

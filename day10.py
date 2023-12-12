import networkx as nx

# Create the coordinate settings for the connectors
connectors = {
    "|" : [(-1, 0), (1, 0)],
    "-" : [(0, -1), (0, 1)],
    "L" : [(-1, 0), (0, 1)],
    "J" : [(-1, 0), (0, -1)],
    "7" : [(1, 0), (0, -1)],
    "F" : [(1, 0), (0, 1)]
}

# Read input into list of list of chars
inp = [[c for c in l.strip()] for l in open("data/day_10.txt").readlines()]

# Create empty DiGraph with dimensions of outer list above
G = nx.create_empty_copy(
    nx.grid_2d_graph(
        len(inp[0]),
        len(inp),
        create_using = nx.DiGraph
    )
)

# At every character, add unidirectional connections (edges) to connected nodes
for i, l in enumerate(inp):
    for j, c in enumerate(l):
        # Special case for starting tile: Add edges to all surrounding and capture coordinates
        if c == "S":
            G.add_edges_from(
                [
                    (
                        (i, j),
                        (i + x, j + y)
                    )
                    for x in range(-1, 2)
                    for y in range(-1, 2)
                    if abs(x + y) == 1
                ]
            )
            sx, sy = i, j
            continue
        for connector in connectors.get(c, []):
            G.add_edge(
                (i, j),
                (i + connector[0], j + connector[1])
            )

# Remove all edges that only exist in one direction
G.remove_edges_from(
    (i, j)
    for i, j in G.copy().edges()
    if not G.has_edge(j, i)
)

# Find the length of the cycle. Half of it is the furthest distance
print(len(nx.find_cycle(G.to_undirected(), (sx, sy))) // 2)

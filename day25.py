import networkx as nx
G = nx.Graph()
f = open("data/day_25.txt").read().splitlines()
nodes = []
for x in f:
  node = x.split(":")[0]
  nodes.append(node)
  cons = x.split(": ")[1].split(" ")
  for con in cons:
    G.add_edge(node, con, capacity=1.0)

for i in range(1,len(f)):
  cut_value, partition = nx.minimum_cut(G,nodes[0],nodes[i])
  if cut_value == 3:
    print("Part 1:", len(partition[0])*len(partition[1]))
    break

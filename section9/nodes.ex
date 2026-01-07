# Nodes, Tasks and Agents.
# A Node is an erlang virtual machine, also know as BEAM.
# You can have as many nodes as you want.

# "iex --name test@something" will run the BEAM node with the name test@something.
# "iex --sname test" will run the BEAM node with the name test.

# You can connect two nodes together by using the "Node.connect" function.
# 'Node.connect :test@something ' will connect the current node to the node with the name test@something.

# You can list all the nodes by using the "Node.list" function.
# 'Node.list' will list all the nodes in the cluster.

# 'Node.spawn :test@something, fn -> IO.puts "Hello from the other side!" end' will spawn a new process on the node with the name test@something.

# Use 'iex --sname test --cookie some-cookie-name' to ensure that no other nodes can connect to this node unless they have the same cookie.

# You can send a message from a node to another node with the folliwing command:
# 'send {:shell, :"test@Justins-MacBook-Pro"}, "hello there obi wan!"'

# You can then receive the message on the other node with the following command:
# 'flush'

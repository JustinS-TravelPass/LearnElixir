# Quoted Expressions return the parameters of a function as a duple.
# If you run 'quote do 2 * 3 end' in iex
# We get back '{:*, [context: Elixir, imports: [{2, Kernel}]], [2, 3]}'

# If you run 'quote do 2 end' in iex
# We get back '2'

# If we run 'quote do elem(2, {1,2,3}) end'
# We get back '{:elem, [context: Elixir, imports: [{2, Kernel}]], [2, {:{}, [], [1, 2, 3]}]}'

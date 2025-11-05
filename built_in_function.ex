defmodule BuiltInFunction.List do
  def delete(index) when not is_integer(index) or index < 0 or index == :nil, do: {:error, :invalid_index}
  def delete(index) do
    List.delete_at(list(), index)
  end

  def flatten do
    list_of_lists = [list(), list(), list()]
    List.flatten(list_of_lists)
  end

  def first do
    List.first(list())
  end

  def last do
    List.last(list())
  end

  def insert do
    List.insert_at(list(), 2, "foobar")
  end

  def list do
    [1,2,3,4,5]
  end
end

BuiltInFunction.List.delete(0) |> IO.inspect # <-- returns [2,3,4,5]

BuiltInFunction.List.flatten() |> IO.inspect # <-- returns [1,2,3,4,5,1,2,3,4,5,1,2,3,4,5]

BuiltInFunction.List.first() |> IO.inspect # <-- returns 1

BuiltInFunction.List.last() |> IO.inspect # <-- returns 5

BuiltInFunction.List.insert() |> IO.inspect # <-- returns [1,2,"foobar",3,4,5]

defmodule BuiltInFunction.Enum do
  def all do
    list() |> Enum.all?(&Kernel.is_integer/1)
  end

  def each do
    list() |> Enum.each(&IO.puts/1)
  end

  def map do
    list() |> Enum.map(&(&1 * 2))
  end

  def reduce do
    list() |> Enum.reduce(0, &(&1 + &2))
  end

  def max do
    list() |> Enum.max()
  end

  def min do
    list() |> Enum.min()
  end

  def list do
    [1,2,3,4,5]
  end
end

BuiltInFunction.Enum.all() |> IO.inspect # <-- returns true

BuiltInFunction.Enum.each() |> IO.inspect # <-- returns 1, 2, 3, 4, 5

BuiltInFunction.Enum.map() |> IO.inspect # <-- returns [2, 4, 6, 8, 10]

BuiltInFunction.Enum.reduce() |> IO.inspect # <-- returns 15

BuiltInFunction.Enum.max() |> IO.inspect # <-- returns 5

BuiltInFunction.Enum.min() |> IO.inspect # <-- returns 1

defmodule BuiltInFunction.Map do
  def get do
    Map.get(map(), :title)
  end

  def has_key do
    map() |> Map.has_key?(:year)
  end

  def merge do
    map() |> Map.merge(%{director: "James Cameron"})
  end

  def keys do
    map() |> Map.keys()
  end

  def pattern_matching do
    %{title: my_title} = map()
    my_title
  end

  def update do
    new_map =%{map() | title: "The Dark Knight", year: 2008}
    new_map
  end

  def map do
    %{title: "Titanic", year: 1997}
  end
end

BuiltInFunction.Map.get() |> IO.inspect # <-- returns "Titanic"

BuiltInFunction.Map.has_key() |> IO.inspect # <-- returns true

BuiltInFunction.Map.merge() |> IO.inspect # <-- returns %{title: "Titanic", year: 1997, director: "James Cameron"}

BuiltInFunction.Map.keys() |> IO.inspect # <-- returns [:title, :year]

BuiltInFunction.Map.pattern_matching() |> IO.inspect # <-- returns "Titanic"

BuiltInFunction.Map.update() |> IO.inspect # <-- returns %{title: "The Dark Knight", year: 2008}

defmodule BuiltInFunction.Keyword do
  def get_value do
    keyword() |> Keyword.get(:color)
  end

  def get_values do
    keyword() |> Keyword.get_values(:size)
  end

  def keyword do
    [color: :red, size: 10, size: 400]
  end
end

BuiltInFunction.Keyword.get_value() |> IO.inspect # <-- returns :red

BuiltInFunction.Keyword.get_values() |> IO.inspect # <-- returns [10, 400]

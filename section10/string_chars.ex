defmodule Employee do
  defstruct name: "", salary: 0

  defimpl String.Chars do
    def to_string(%Employee{name: name, salary: salary}) do
      "Employee: #{name} - #{salary}"
    end
  end
end

defmodule Demo do
  def work do
    # Will print out the struct using the String.Chars protocol.
    %Employee{name: "John Doe", salary: 100_000} |> IO.puts()
    # Will print out the full struct using the inspect function.
    %Employee{name: "John Doe", salary: 100_000} |> IO.inspect()
  end
end

Demo.work()

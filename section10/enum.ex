defmodule Company do
  defstruct title: "", employees: []

  defimpl Enumerable do
    def reduce(_, {:halt, result}, _fun), do: {:halted, result}

    def reduce(%Company{employees: _employees} = company, {:suspend, result}, fun) do
      {:suspended, result, &reduce(company, &1, fun)}
    end

    def reduce(%Company{employees: []}, {:cont, result}, _fun), do: {:done, result}

    def reduce(%Company{employees: [head | tail]}, {:cont, result}, fun) do
      reduce(%Company{employees: tail}, fun.(head, result), fun)
    end

    def count(%Company{employees: employees}) do
      {:ok, Enum.count(employees)}
    end

    def member?(%Company{employees: employees}, employee) do
      {:ok, Enum.member?(employees, employee)}
    end
  end
end

defmodule Employee do
  defstruct name: "", salary: "", works_for: 0

  defimpl String.Chars do
    def to_string(%Employee{name: name, salary: salary}) do
      "Employee: #{name} - #{salary}"
    end
  end
end

defmodule Demo do
  def work do
    company = %Company{
      title: "Google",
      employees: [
        %Employee{name: "John Doe", salary: "for food", works_for: 1},
        %Employee{name: "Jane Doe", salary: "very high", works_for: 2},
        %Employee{name: "Jim Doe", salary: "who knows", works_for: 3}
      ]
    }

    # Counts the number of employees in the company.
    Enum.count(company) |> IO.inspect()

    # Checks if the employee is a member of the company.
    Enum.member?(company, %Employee{name: "John Doe", salary: "for food", works_for: 1})
    |> IO.inspect()

    Enum.reduce(company, 0, fn employee, total_years -> employee.works_for + total_years end)
    |> IO.inspect()
  end
end

Demo.work()

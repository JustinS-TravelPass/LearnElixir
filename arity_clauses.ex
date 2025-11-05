#This file walks through arity clauses in Elixir. Arity is the number of arguments a function takes.

defmodule ArityClauses.Calc do

  def factorial(0) do
    1
  end

  # Factorial of 5
  def factorial(a) when is_integer(a) and a > 0 do # The "when" expression is called a "guard clause". && and || are not suported in guard clauses.
    a * factorial(a - 1)
  end

  # This function acts as a fallback function in the case that the argument is not an integer or is less than 0.
  def factorial(_) do
    {:error, :invalid_argument}
  end

  # The arity of this function is written as divide/2. If the divide function is called with the second argument being 0, the function will return an error.
  # You can change what funciton is called based on the pattern matching of the arguments.
  # The function below will only be called if the second argument is 0.
  # Otherwise the second divide function will be called.
  def divide(_a, 0) do
    {:error, :zero_division}
  end

  def divide(a, b) do
    a / b
  end

  # The Arity of plus can be written as plus/1 meaning the plus function takes 1 argument.
  def plus(a) do
    plus a, 0
  end

  #The Arity of this function can be written as plus/2. We've made the second argument optional and set its default value to 0.
  def plus(a, b \\ 0) do
    a + b
  end
end

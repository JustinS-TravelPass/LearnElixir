defmodule Exceptions do
  def run do
    try do
      # The bang after the function name means that this function can return an error.
      Keyword.fetch!([], :a)
    rescue
      e in KeyError -> e
    end
  end

  def run2 do
    try do
      Keyword.fetch!([], :a)
    rescue
      KeyError -> "Key cannot be found..."
    end
  end

  # This is most useful for handling API calls.
  def run3 do
    try do # This is kind of like a try catch block in other languages like Javascript.
      Keyword.fetch!([], :a)
    rescue # This is like the catch block in other languages like Javascript.
      KeyError -> "Key cannot be found..."
      ArgumentError -> "Argument error..."
    after # This is like the finally block in other languages like Javascript.
      IO.puts("I've executed no matter what!")
    else # Executes only if there are no errors. This is like then .then block in other languages like Javascript.
      5 -> "found five!"
      _ -> "not sure what this is..."
    end
  end

  def run4(arg) do
    raise ArgumentError, message: "A required argument was not provided!: #{arg}"
  end

  # You can create your own exceptions by defining a defexception module.
  # This will allow you to raise a generic error.
  defexception message: "An error occured!"
  def run5() do
    raise Exceptions
  end

  def run6 do
    try do
      throw "error"
    catch
      "error" -> "error caught!"
      _ -> "unknown error!"
    end
  end

  # Process Exits normally
  def run7 do
    try do
      exit :normal
    catch
      _ -> ""
    end
  end

  def run8 do
    try do
      exit :very_bad
    catch
      :exit, :very_bad -> "very bad error!"
      :exit, _ -> "very very bad error!"
    end
  end
end

Exceptions.run() |> IO.inspect

Exceptions.run2() |> IO.inspect

Exceptions.run3() |> IO.inspect

# Exceptions.run4("test") |> IO.inspect

# Exceptions.run5() |> IO.inspect

# Exceptions.run6() |> IO.inspect

# Exceptions.run7() |> IO.inspect

Exceptions.run8() |> IO.inspect
